/*
 (c) Copyright, Real-Time Innovations, $Date: 2009/05/17 01:14:45 $.
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
*/

/*
 * ThroughputArgs.h
 *
 * This is a class for parsing and validating arguments to the
 * Throughput test publisher/subscriber
 *
 */

#ifndef ThroughputArgs_h
#define ThroughputArgs_h

#include "Throughput.h"

#define THROUGHPUT_TEST_MAX_NODES 16
#define THROUGHPUT_TEST_DOMAIN_DEFAULT 0
#define MAX_COMMAND_LINE_ARGUMENTS 80
#define MAX_COMMAND_EXEC_LEN 256
#define MAX_PEER_LOCATOR_STR_LEN 128
#define MAX_PEER_PART_IDX 4
/* Allow a maximum of 5 participants (0..4) per node. */

#define DEFAULT_TEST_VERBOSITY TEST_VERBOSITY_ERRORS
#define DEFAULT_NDDS_VERBOSITY 1

#define _MAX_FILENAME_LENGTH 260


/* Parent class */
class ThroughputArgs {
  public:
    /* Constructors */
    ThroughputArgs();
    virtual ~ThroughputArgs() {
        /* Free the arguments buffer if allocated */
        if (_arguments_buff != NULL) {
            free(_arguments_buff);
        }
    }

    /* This method just ensures that the list of peers
       is not accessed out of bounds */
    char* get_peer_host(int index) {
        if (index > THROUGHPUT_TEST_MAX_NODES) {
            return NULL;
        } else {
            return _peer_hosts[index];
        }
    }

    /* The user can check if the arguments are valid. */
    inline DDS_Boolean is_valid() {return _args_valid;}
    /* The user can check if the help was an argument. */
    inline DDS_Boolean is_help_requested() {return _help_requested;}
    /* Or if the user has selected reliable mode for the test */
    inline DDS_Boolean is_reliable() {return _reliable;}

    inline int transport_to_use() { return _transport_to_use; }

    char *get_ip_interface(){
        if (!strcmp(_nic, "")) {
            return NULL;
        } else {
            return _nic;
        }
    }

    int mi_instance_count, mi_inactive_count;

    /* Print out the error string. */
    void print_error(void);

  protected: /* Class variables available to derived classes only */
    char _peer_hosts[THROUGHPUT_TEST_MAX_NODES][MAX_PEER_LOCATOR_STR_LEN];
    char _error_string[128];
    char _nic[MAX_PEER_LOCATOR_STR_LEN];
    /* Used to restrict the (NIC) interface that the test uses */

    /* Name of configuration file */
    char _config_file_name[_MAX_FILENAME_LENGTH];

    char *_arguments_buff; /* Pointer to buffer to hold arguments from file. */
    char *_arg_variables[MAX_COMMAND_LINE_ARGUMENTS];
    /* Arguments parsed from file buffer */

    DDS_Boolean _args_valid;
    DDS_Boolean _reliable;
    DDS_Boolean _help_requested;
    int _transport_to_use;
    char _command[MAX_COMMAND_EXEC_LEN];

  protected:
    /* Private virtual functions which should be overloaded in a derived class
       and only called from within a derived class */

    /* Must be implemented in derived class */
    virtual DDS_Boolean parse_arguments(int, char **) = 0;

    /* Check that parameters provided are valid for the derived class */
    virtual DDS_Boolean validate_args(void);

    /* Parse the specific arguments for the derived class. */

    /* If arguments are not valid then the 'usage' method can be called */
    virtual void usage(void);

    /* Print out the arguments used for the test. */
    virtual void print_arguments(void);

  protected:
    /* Initialize base class members with defaults */
    void initialize(const char *command);

    /* utility function in case the derived class uses
       constructor with a file name. */
    int construct_args_from_file(char* configFileName, int &argCount);

    /* Parse common arguments */
    int parse_common_args(int &arg, char ** argv);

  public:
    /* Class variables are public, but could be made private with accessors. */
    int ndds_domain; /* Test domain */
    int max_peer_index; /* Number of peers */
    int participant_id; /* the participant Id which must be supplied */
    int ndds_verbosity; /* NDDS verbosity */
    int test_verbosity; /* Test verbosity */
    const char* exe_name;
};

class ThroughputPublisherArgs : public ThroughputArgs {
  public:
    virtual ~ThroughputPublisherArgs(void);
    ThroughputPublisherArgs(void);
    ThroughputPublisherArgs(int argc, char **argv);
    ThroughputPublisherArgs(char* argumentsFile);

    /* Functions that override base class pure virtual public functions
       If arguments are not valid then the Usage method can be called */
    void usage(void);
    /* Arguments used for the test can be printed */
    void print_arguments(void);
    /* the error string can be printed */
    void print_error(void);

    DDS_Duration_t get_max_blocking_time();

    void set_max_blocking_time(unsigned long msec);

  private:
    /* Defines the different packet sizes that are used
       for testing when in auto mode. */
    /* Maximum blocking time for a reliable writer */
    DDS_Duration_t _max_blocking_time;
    /* Hold user input in ms before conversion to DDS_Duration_t */
    unsigned long _blocking_time;

    /* Private functions which override base class pure virtual functions */
  private:

    /* With defaults for the Publisher */
    void initialize(const char *);
    /* Check that parameters provided are valid for the publisher */
    DDS_Boolean validate_args(void);
    /* Parse the command line or constructed command line arguments */
    DDS_Boolean parse_arguments(int, char**);

  public: /* Class specific member variables */
    /* for single host test, keep at 0 to avoid lots of mcast packets */
    int multicast_ttl;
    int packet_size; /* Size of the message sequence */
    int test_duration_sec; /* Duration of test */
    int subscribers; /* Number of subscribers IP addresses supplied */
    int strength; /* For the reliable writers */
    int bw_limit; /* Maximum B/W allowed by flow controller [Mbit/s]
                     Only applies when using large data */
    DDS_Boolean asynchronous;
    /* Whether to send data asynchronously or not.
       N/A for large data (always sent asynchronously) */

    int recovery_time_msec; /*sleep time / write loop*/
    int demand_initial; /* Demand messages / write loop */
    int demand_increment;
    int demand_max;
    DDS_Boolean no_push_on_write; /* whether the writer should push */
};

/* Subscriber arguments */
/* Derived classes for Publisher arguments or Subscriber arguments */

class ThroughputSubscriberArgs: public ThroughputArgs {
  public:
    /* Constructors */
    ThroughputSubscriberArgs(void);
    ThroughputSubscriberArgs(int argc, char **argv);
    ThroughputSubscriberArgs(char* argumentsFile);
    /* Destructor */
    virtual ~ThroughputSubscriberArgs(void);

    /* Functions which override base class pure virtual public functions
       If arguments are not valid then the 'usage()' method can be called */
    void usage(void);
    /* Print what was used during the test */
    void print_arguments(void);
    /* the error string can be printed */
    void print_error(void);

  private: /* Private functions which override base class virtual functions */

    /* With defaults for the Subscriber */
    void initialize(const char *command);

    /* Check that parameters provided are valid for the subscriber */
    DDS_Boolean validate_args(void);

    /* Parse the command line or constructed command line */
    DDS_Boolean parse_arguments(int, char**);

  public: /* Class specific public members */
    char* mcast_recv_addr;
};


#endif

