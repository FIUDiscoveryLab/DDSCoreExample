/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#include <iostream>
#include <string>
#include <cstdlib>
#include <fstream>

#include <ndds/ndds_cpp.h>

#include "News.h"
#include "NewsPublisher.h"
#include "NewsSubscriber.h"


/* The News example implements a simple application: a variety of news
 * outlets publish articles at different rates, and subscribers consume the
 * data based on different criteria. It demonstrates several important design
 * patterns.
 */

/****************************************************************************/
/* Local constants & macros                                                 */
/****************************************************************************/

/* Command line defaults */
#define DEFAULT_DOMAIN_ID           0

/* Application running mode */
#define APP_MODE_UNDEFINED          0
#define APP_MODE_PUBLISHER          1
#define APP_MODE_SUBSCRIBER         2

/* This is the name of the topic used for our test */
#define TOPIC_NAME                  "News Example"

/* The maximum value for Domain ID. The effective value depends on the QoS,
 * in particular to the value of the field:
 *              DDS_RtpsWellKnownPorts_t.domainId_gain
 * The default value is 250, so we just limit to that statically so we can
 * check the validity before attempting to create the domain participant.
 */
#define DOMAIN_ID_MAX               250

#define RUN_SECONDS_DEFAULT         20


/****************************************************************************/
/* Structure to hold the parsed command line arguments                      */
/****************************************************************************/
struct CommandLineArguments {
    DDS_Long    domainId;
    DDS_Long    mode;

    // The number of seconds for which this application should run.
    DDS_Long    runSeconds;
    DDS_Long    verbose;        /* 0=no verbose, 1=app verbose, 2=DDS */
    /* If the subscribing application is using a content-based filter to
     * down-sample the incoming data, the filter expression will be stored
     * here.
     */
    std::string contentFilter;
    
    CommandLineArguments()
            : domainId(DEFAULT_DOMAIN_ID),
              mode(APP_MODE_UNDEFINED),
              runSeconds(RUN_SECONDS_DEFAULT),
              verbose(0),
              contentFilter("") {
        // empty
    }
};



/****************************************************************************/
/* Overload the std::ostream::operator<<() to print a                       */
/* DDS_ProductVersion_t.                                                    */
/****************************************************************************/
std::ostream &operator<<(std::ostream &os, const DDS_ProductVersion_t &arg) {
    os << (int)arg.major << '.' 
       << (int)arg.minor
       << (char)arg.release << " (build "
       << (int)arg.revision << ')';
    return os;
}

/****************************************************************************/
/* fileExist                                                                */
/*                                                                          */
/* Just a convenience function that checks if a file exist and can be read  */
/****************************************************************************/
static bool fileExist(const char *fileName) {
    std::ifstream stream;
    stream.open(fileName);
    if (!stream) {
        return false;
    }
    stream.close();
    return true;
}


/****************************************************************************/
/* start_application                                                        */
/*                                                                          */
/* Creates the DDS Domain Participant, then delegates the execution to the  */
/* correct pub/sub function.                                                */
/* If entity creation is successful, this function does not return.         */
/*                                                                          */
/* Input:                                                                   */
/*   arg: pointer to the CommandLineArguments structure                     */
/*                                                                          */
/* Returns:                                                                 */
/*   false if an error occurred.                                            */
/*                                                                          */
/****************************************************************************/
static bool startApplication(
                        const CommandLineArguments &arg) {
    DDS_ReturnCode_t         rc;
    DDSTopic *               topic = NULL;
    bool                     returnValue = false;

    /* This example creates DDS entities using the default QoS loaded
     * from the file USER_QOS_PROFILES.xml in the current working
     * directory.
     */
    if (!fileExist("USER_QOS_PROFILES.xml")) {
        std::cout << "! Unable to locate QoS definition file" << std::endl;
        std::cout << "! (USER_QOS_PROFILES.xml) in current directory."
                  << std::endl;
        return false;
    }

    DDSDomainParticipantFactory* factory =
        DDSDomainParticipantFactory::get_instance();
    /* If you need to customize any DDS factory QoS, uncomment the following
     * code: 
     *
    {
        DDS_DomainParticipantFactoryQos factoryQos;
        rc = factory->get_qos(factoryQos);
        if (rc != DDS_RETCODE_OK) { 
            std::cerr << "! Unable to get participant factory QoS: "
                      << rc << std::endl;
            goto exitFn;
        }
        
        // Modify the factory QoS here
        
        rc = factory->set_qos(factoryQos);
        if (rc != DDS_RETCODE_OK) { 
            std::cerr << "! Unable to set participant factory QoS: "
                      << rc << std::endl;
            goto exitFn;
        }
    }
    */
    
            
    /* Creates the DDS Domain Participant.
     * If you want to create a domain participant with different QoS,
     * use DDSDomainParticipantFactory::get_default_participant_qos
     * to obtain a copy of the default participant QoS, change them,
     * then use them instead of DDS_PARTICIPANT_QOS_DEFAULT:
     *
    {
        DDS_DomainParticipantQos myQos;
        factory->get_default_participant_qos(myQos);
        // Modify the participant QoS here
        // Then create the domain participant using 'myQos'...
    }
     */
    if (arg.verbose) {
        std::cout << "Creating domain participant..." << std::endl;
    }
    DDSDomainParticipant* participant = factory->create_participant(
            arg.domainId,
            DDS_PARTICIPANT_QOS_DEFAULT,
            NULL,                    // no listener
            DDS_STATUS_MASK_NONE);   // no listener callbacks
    if (participant == NULL) {
        std::cerr << "! Unable to create DomainParticipant" << std::endl;
        goto exitFn;
    }

    /* Creates the topic.
     * If you want to create a topic with different QoS,
     * use DDSDomainParticipant::get_default_topic_qos
     * to obtain a copy of the default topic QoS, change them,
     * then use them instead of DDS_TOPIC_QOS_DEFAULT:
     *
    {
        DDS_TopicQos myQos;
        participant->get_default_topic_qos(myQos);
        
        // Modify the topic QoS here
        // Then create the topic using 'myQos'...        
    }
     */
    if (arg.verbose) {
        std::cout << "Creating the topic..." << std::endl;
    }
    topic = participant->create_topic(
            TOPIC_NAME,
            DDSKeyedStringTypeSupport::get_type_name(), 
            DDS_TOPIC_QOS_DEFAULT,
            NULL,                    // no listener
            DDS_STATUS_MASK_NONE);    // no listener callbacks
    if (topic == NULL) {
        std::cerr << "! Unable to create topic" << std::endl;
        goto exitFn;
    }

    /* Creates the publisher or subscriber */
    try {
        if (arg.mode == APP_MODE_PUBLISHER) {
            NewsPublisher pub(
                    participant, topic, arg.verbose, arg.runSeconds);
            pub.publish();
        } else {
            NewsSubscriber sub(
                    participant,
                    topic,
                    arg.verbose,
                    arg.runSeconds,
                    arg.contentFilter);
            sub.readArticles();
        }
        returnValue = true;
    } catch (std::exception& ex) {
        std::cerr << "An error occurred: " << ex.what();
    }
    
exitFn:
    if (arg.verbose) {
        std::cout << "Cleaning up..." << std::endl;
    }
    if (participant != NULL) {
        /* Perform a clean shutdown of the participant and all the contained
         * entities
         */
        rc = participant->delete_contained_entities();
        if (rc != DDS_RETCODE_OK) {
            std::cerr << "! Unable to delete participant contained entities: "
                      << rc << std::endl;
        }

        rc = factory->delete_participant(participant);
        if (rc != DDS_RETCODE_OK) {
            std::cerr << "! Unable to delete participant: " << rc << std::endl;
        }
    }
    DDSDomainParticipantFactory::finalize_instance();
    return returnValue;
}




/****************************************************************************/
/* usage                                                                    */
/*                                                                          */
/* Prints help on command line accepted by this application                 */
/****************************************************************************/
static void usage() {
    std::cout << "Usage:" << std::endl;
    std::cout << "    News pub [arguments]     Run as publisher" << std::endl;
    std::cout << "    News sub [arguments]     Run as subscriber" << std::endl;
    std::cout << "Where arguments are:" << std::endl;
    std::cout << "  -h | --help                   "
              << "Shows this page" << std::endl;
    std::cout << "  -v | --verbose                "
              << "Increase output verbosity (can be repeated)" << std::endl;
    std::cout << "  -d | --domain <domainID>      "
              << "Sets the DDS domain ID [default=" << DEFAULT_DOMAIN_ID 
              << ']' << std::endl;
    std::cout << "  -r | --runSeconds <integer>   "
              << "Sets the number of seconds to run [default=20]" << std::endl;
    std::cout << "  -f | --filterExpression <SQL> "
              << "Sets a content filter on the data" << std::endl;
    std::cout << std::endl;
}


/****************************************************************************/
/* ENSURE_ONE_MORE_ARGUMENT                                                 */
/*                                                                          */
/* A simple macro used to check if there are enough command line args       */
/****************************************************************************/
#define ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, argName)                     \
    if (i+1 >= argc) {                                                        \
        usage();                                                             \
        std::cerr << "! Error: missing value for " << argName                \
                  << " argument" << std::endl;                               \
        return EXIT_FAILURE;                                                 \
    }


/****************************************************************************/
/* main                                                                     */
/*                                                                          */
/* Application main entry point                                             */
/****************************************************************************/
int main(int argc, const char **argv) {
    CommandLineArguments arg;

    std::cout << "RTI News Example" << std::endl;
    std::cout << "Copyright 2009 Real-Time Innovations, Inc.\n" << std::endl;

    /* Ensure there are enough arguments in the command line */
    if (argc < 2) {
        usage();
        std::cerr << "! Invalid number of arguments." << std::endl;
        std::cerr << "! You must specify at least running mode (pub/sub)" 
                  << std::endl;
        return EXIT_FAILURE;
    }

    /* Parse the running mode: pub/sub */    
    if (RTI_STRCASECMP(argv[1], "pub") == 0) {
        arg.mode = APP_MODE_PUBLISHER;
    } else if (RTI_STRCASECMP(argv[1], "sub") == 0) {
        arg.mode = APP_MODE_SUBSCRIBER;
    } else if (!RTI_STRNCMP(argv[1], "-h", 2) || 
               !RTI_STRNCMP(argv[1], "--help", 6)) {
        usage();
        return EXIT_SUCCESS;
    } else {
        usage();
        std::cerr << "! Invalid mode: '" << argv[1] << "'" << std::endl;
        std::cerr << "! Valid modes are only 'pub' or 'sub'" << std::endl;
        return EXIT_FAILURE;
    }

    /* Parse the optional arguments */
    for (int i = 2; i < argc; ++i) {
        if (!RTI_STRNCMP(argv[i], "-h", 2) || 
            !RTI_STRNCMP(argv[i], "--help", 6)) {
            usage();
            return EXIT_SUCCESS;
        }
        
        if (!RTI_STRNCMP(argv[i], "-v", 2) || 
            !RTI_STRNCMP(argv[i], "--verbose", 9)) {
            ++arg.verbose;
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-d", 2) || 
            !RTI_STRNCMP(argv[i], "--domain", 8)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--domain")
            arg.domainId = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                std::cerr << "! Value of --domain argument is not a number: " 
                          << argv[i] << std::endl;
                return EXIT_FAILURE;
            }
            if (arg.domainId < 0 || arg.domainId > DOMAIN_ID_MAX) {
                usage();
                std::cerr << "! Invalid DDS Domain ID: " << arg.domainId
                          << std::endl;
                std::cerr << "! The domain ID must be between 0 and "
                          << DOMAIN_ID_MAX << " (inclusive)" << std::endl;
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-r", 2) ||
            !RTI_STRNCMP(argv[i], "--runSeconds", 12)) {
            char *ptr;
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--runSeconds")
            arg.runSeconds = strtol(argv[++i], &ptr, 10);
            if (*ptr != '\0') {
                usage();
                std::cerr << "! Invalid value for --runSeconds option:"
                          << argv[i] << std::endl;
                return EXIT_FAILURE;
            }
            if (arg.runSeconds <= 0) {
                usage();
                std::cerr << "! Invalid value for --runSeconds argument: "
                          << arg.runSeconds << std::endl;
                return EXIT_FAILURE;
            }
            continue;
        }

        if (!RTI_STRNCMP(argv[i], "-f", 2) || 
            !RTI_STRNCMP(argv[i], "--filterExpression", 18)) {
            ENSURE_ONE_MORE_ARGUMENT(argc, argv, i, "--filterExpression")
            arg.contentFilter = argv[++i];
            continue;
        }
        
        usage();
        std::cerr << "! Unknown argument " << argv[i] << std::endl;
        return EXIT_FAILURE;
    } /* foreach argument */

    if (arg.verbose) {
        const DDS_ProductVersion_t &prodVersion = 
                        NDDSConfigVersion::get_instance().get_product_version();
        std::cout << "Running with the following arguments:" << std::endl;
        std::cout << "    Verbosity level.. : " << arg.verbose << std::endl;
        std::cout << "    Domain ID........ : " << arg.domainId << std::endl;
        std::cout << "    Seconds to run... : " << arg.runSeconds << std::endl;
        std::cout << "    Content filter... : " << arg.contentFilter << std::endl;
        std::cout << "RTI Product Version.. : " << prodVersion << std::endl;        
    }

    // If the verbosity is greater than 1, also turn on RTI status logging.
    if (arg.verbose > 1) {
        NDDSConfigLogger::get_instance()->set_verbosity_by_category(
                        NDDS_CONFIG_LOG_CATEGORY_API,
                        NDDS_CONFIG_LOG_VERBOSITY_STATUS_ALL);
    }

    /* Finally, starts the application */
    startApplication(arg);

    /* start_application terminates if sampleCount is set */
    std::cout << "Done." << std::endl;
    return EXIT_SUCCESS;
}


/****************************************************************************/
/* Article Class                                                            */
/****************************************************************************/

#define MIN_NAME_WIDTH 10

Article::Article(const std::string& newsOutletName,
                 const std::string& articleText) {
    /* For formatting purposes, make sure all of the news outlet
     * names are padded to the same width.
     */
    _stringified = "From ";
    _stringified += newsOutletName;
    for (int i = newsOutletName.length(); i < MIN_NAME_WIDTH; ++i) {
        _stringified += ' ';
    }
    _stringified += ": \"";
    _stringified += articleText;
    _stringified += "\"";
}

Article::Article(const Article& src) : _stringified(src._stringified) {
    // empty
}

std::ostream& operator <<(std::ostream& stream, const Article& article) {
    stream << article._stringified;
    return stream;
}
