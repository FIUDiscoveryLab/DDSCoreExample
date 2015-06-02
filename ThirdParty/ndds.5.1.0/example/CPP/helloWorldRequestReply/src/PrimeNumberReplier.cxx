/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#include <math.h>
#include <iostream>
#include <vector>

/*
 * Include the generated support for the request and reply types
 */
#include "idl/Primes.h"
#include "idl/PrimesSupport.h"

/*
 * Include the request-reply API
 */
#include "ndds/ndds_requestreply_cpp.h"

class PrimeNumberReplierExample {

private:
    DDS::DomainParticipant * participant;

public:
    PrimeNumberReplierExample(int domain_id)
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

    ~PrimeNumberReplierExample()
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

private:
    void calculate_and_send_primes(
        connext::Replier<PrimeNumberRequest, PrimeNumberReply>& replier,
        const connext::Sample<PrimeNumberRequest>& request)
    {
        int n = request.data().n;
        int primes_per_reply = request.data().primes_per_reply;

        connext::WriteSample<PrimeNumberReply> reply;
        reply.data().primes.maximum(primes_per_reply);
        reply.data().status = REPLY_IN_PROGRESS;

        /* prime[i] indicates if i is a prime number
         * Initially, we assume all of them are prime
         */

        std::vector<bool> prime(n+1, true);

        prime[0] = false;
        prime[1] = false;

        int m = (int) sqrt((float)n);

        for (int i = 2; i <= m; i++) {
            if (prime[i]) {
                for (int k = i*i; k <= n; k+=i) {
                    prime[k] = false;
                }

                /* Add a new element */
                DDS::Long length = reply.data().primes.length();
                reply.data().primes.length(length + 1);
                reply.data().primes[length] = i;

                if (length + 1 == primes_per_reply) {
                    /* Send a reply now */
                    replier.send_reply(reply, request.identity());
                    reply.data().primes.length(0);
                }
            }
        }

        /* Calculation is done. Send remaining prime numbers */
        for (int i = m + 1; i <= n; i++) {
            if (prime[i]) {

                DDS::Long length = reply.data().primes.length();
                reply.data().primes.length(length + 1);
                reply.data().primes[length] = i;

                if (length + 1 == primes_per_reply) {
                    /* Send a reply now */
                    replier.send_reply(reply, request.identity());
                    reply.data().primes.length(0);
                }
            }
        }

        /* Send the last reply. Indicate that the calculation is complete and
         * send any prime number left in the sequence
         */
        reply.data().status = REPLY_COMPLETED;
        replier.send_reply(reply, request.identity());
    }

public:
    void run_example()
    {

        connext::ReplierParams<PrimeNumberRequest, PrimeNumberReply>
            replier_params(participant);

        replier_params.service_name("PrimeCalculator");
        replier_params.qos_profile(
            "RequestReplyExampleProfiles", "ReplierExampleProfile");

        /* In this example we create the replier on the stack, but you
         * can create on the heap as well
         */
        connext::Replier<PrimeNumberRequest, PrimeNumberReply> replier(
            replier_params);

        /*
         * Receive requests and process them
         */

        connext::Sample<PrimeNumberRequest> request;
        const DDS::Duration_t MAX_WAIT = {20, 0};

        /* receive_request returns false when it times out */
        while(replier.receive_request(request, MAX_WAIT)) {

            if (!request.info().valid_data) {
                continue;
            }

            /* This constant is defined in Primes.idl */
            if (request.data().n <= 0 ||
                request.data().primes_per_reply <= 0 ||
                request.data().primes_per_reply > PRIME_SEQUENCE_MAX_LENGTH) {

                std::cout << "Cannot process request" << std::endl;

                /* Send reply indicating error */
                connext::WriteSample<PrimeNumberReply> error_reply;
                error_reply.data().status = REPLY_ERROR;

                replier.send_reply(error_reply, request.identity());

            } else {
                std::cout << "Calculating prime numbers below "
                          << request.data().n << "... " << std::endl;

                calculate_and_send_primes(replier, request);

                std::cout << "DONE" << std::endl;
            }
        }
    }
};

int main(int argc, char *argv[])
{
    int domain_id = 0;

    if (argc > 1) {
        domain_id = atoi(argv[1]);
    }

    /* Uncomment this to turn on additional logging
        NDDSConfigLogger::get_instance()->set_verbosity(
            NDDS_CONFIG_LOG_VERBOSITY_WARNING);
    */

    std::cout << "PrimeNumberReplier running (on domain " << domain_id << ")"
              << std::endl;

    try {
        /*
         * Run the example
         */
        PrimeNumberReplierExample(domain_id).run_example();

    } catch (const std::exception& ex) {
        std::cout << "Exception: " << ex.what() << std::endl;
        return -1;
    }

    return 0;
}


