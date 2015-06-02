/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#include <iostream>

/*
 * Include the auto-generated support for the request and reply types
 */
#include "idl/Primes.h"
#include "idl/PrimesSupport.h"

/*
 * Include the request-reply API
 */
#include "ndds/ndds_requestreply_cpp.h"

class PrimeNumberRequesterExample {

private:
    DDS::DomainParticipant * participant;

public:
    PrimeNumberRequesterExample(int domain_id)
    {
        /* Create the participant */
        participant = DDS::DomainParticipantFactory::get_instance()->
            create_participant(
                domain_id, DDS::PARTICIPANT_QOS_DEFAULT,
                NULL /* listener */, DDS::STATUS_MASK_NONE);

        if (participant == NULL) {
            throw std::runtime_error("create_participant error");
        }
    }

    ~PrimeNumberRequesterExample()
    {
        /* Delete the participant and all contained entities */

        DDS::ReturnCode_t retcode = participant->delete_contained_entities();
        if (retcode != DDS::RETCODE_OK) {
            printf("delete_contained_entities error %d\n", retcode);
        }

        retcode = DDS::DomainParticipantFactory::get_instance()->
            delete_participant(participant);
        if (retcode != DDS::RETCODE_OK) {
            printf("delete_participant error %d\n", retcode);
        }
    }

    void run_example(int n, int primes_per_reply)
    {
        /* Create the requester with the participant, and a QoS profile
         * defined in USER_QOS_PROFILES.xml
         */
        connext::RequesterParams requester_params(participant);
        requester_params.service_name("PrimeCalculator");
        requester_params.qos_profile(
            "RequestReplyExampleProfiles", "RequesterExampleProfile");

        /* In this example we create the requester on the stack, but you
         * can create on the heap as well
         */
        connext::Requester<PrimeNumberRequest, PrimeNumberReply> requester(
            requester_params);

        /* Send the request */
        connext::WriteSample<PrimeNumberRequest> request;
        request.data().n = n;
        request.data().primes_per_reply = primes_per_reply;

        requester.send_request(request);

        /* Receive replies */
        const DDS::Duration_t MAX_WAIT = {20, 0};

        bool in_progress = true;
        while(in_progress) {
            connext::LoanedSamples<PrimeNumberReply> replies =
                requester.receive_replies(MAX_WAIT);

            /* When receive_replies times out,
             * it returns an empty reply collection
             */
            if (replies.length() == 0) {
                throw std::runtime_error("Timed out waiting for replies");
                return;
            }

            /* Print the prime numbers we receive */
            typedef connext::LoanedSamples<PrimeNumberReply>::iterator iterator;
            for (iterator it = replies.begin(); it != replies.end(); ++it) {
                if (it->info().valid_data) {

                    for (int i = 0; i < it->data().primes.length(); i++) {
                        std::cout << it->data().primes[i] << " ";
                    }

                    if (it->data().status != REPLY_IN_PROGRESS) {
                        in_progress = false;
                        if (it->data().status == REPLY_ERROR) {
                            throw std::runtime_error("Error in replier");
                        } else { /* reply->status == COMPLETED */
                            std::cout << "DONE";
                        }
                    }

                    std::cout << std::endl;
                }
            }

            /* We don't need to call replies.return_loan(); the destructor
             * takes care of doing it every time replies goes out of scope
             */
        }
    }

};

int main(int argc, char *argv[])
{
    int domain_id = 0;
    int n;
    int primes_per_reply = 5;

    if (argc < 2) {
        std::cout << "PrimeNumberRequester" << std::endl
                  << "Sends a request to calculate the prime numbers <= n"
                  << std::endl
                  << "Parameters: <n> [<primes_per_reply>=5] [<domain_id>=0]"
                  << std::endl;
        return -1;
    }

    n = atoi(argv[1]);

    if (argc > 2) {
        primes_per_reply = atoi(argv[2]);
    }

    if (argc > 3) {
        domain_id = atoi(argv[3]);
    }

    /* Uncomment this to turn on additional logging
        NDDSConfigLogger::get_instance()->set_verbosity(
            NDDS_CONFIG_LOG_VERBOSITY_WARNING);
    */

    std::cout << "PrimeNumberRequester: Sending a request to calculate the "
              << "prime numbers <= " << n << " in sequences of "
              << primes_per_reply << " or less elements (on domain "
              << domain_id << ")" << std::endl;

    try {
        /*
         * Run the example
         */
        PrimeNumberRequesterExample(domain_id).run_example(n, primes_per_reply);

    } catch (const std::exception& ex) {
        std::cout << "Exception: " << ex.what() << std::endl;
        return -1;
    }

    return 0;
}


