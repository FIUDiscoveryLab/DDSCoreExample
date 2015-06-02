/* ****************************************************************************
 *         (c) Copyright, Real-Time Innovations, All rights reserved.       
 *                                                                          
 *         Permission to modify and use for internal purposes granted.      
 * This software is provided "as is", without warranty, express or implied. 
 *                                                                          
 * ****************************************************************************
 */
using System;
using System.Collections.Generic;

using DDS;
using RTI.Connext.RequestReply;
using RTI.Connext.Infrastructure;

namespace RequestReplyExample
{
    class PrimeNumberReplier : IDisposable
    {
        // --- Members: -------------------------------------------------------

        private DomainParticipant participant;
        private Replier<PrimeNumberRequest, PrimeNumberReply> replier;

        // --- Constructor: ---------------------------------------------------

        public PrimeNumberReplier(int domainId)
        {

            // Create participant
            participant = DomainParticipantFactory.get_instance()
                .create_participant(
                    domainId,
                    DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT,
                    null, StatusMask.STATUS_MASK_NONE);

            if (participant == null)
            {
                throw new SystemException("Error creating participant");
            }

            // Create replier with that participant
            replier = new Replier<PrimeNumberRequest, PrimeNumberReply>(
                new ReplierParams<PrimeNumberRequest, PrimeNumberReply>(
                    participant,
                    PrimeNumberRequestTypeSupport.get_instance(),
                    PrimeNumberReplyTypeSupport.get_instance())
                .SetServiceName("PrimeCalculator")
                .SetQosProfile("RequestReplyExampleProfiles",
                        "ReplierExampleProfile")
            );
        }

        // --- Dispose: -------------------------------------------------------

        public void Dispose()
        {
            if (replier != null)
            {
                replier.Dispose();
                replier = null;
            }

            if (participant != null)
            {
                participant.delete_contained_entities();
                DomainParticipantFactory.get_instance().
                    delete_participant(ref participant);
                participant = null;
            }
        }

        public void RunReplier()
        {
            Duration_t MAX_WAIT = new Duration_t();
            MAX_WAIT.sec = 60;
            MAX_WAIT.nanosec = 0;

            Sample<PrimeNumberRequest> request = replier.CreateRequestSample();

            while (replier.ReceiveRequest(request, MAX_WAIT))
            {

                if (!request.Info.valid_data)
                {
                    continue;
                }

                // This constant is defined in Primes.idl
                if (request.Data.n <= 0 ||
                    request.Data.primes_per_reply <= 0 ||
                    request.Data.primes_per_reply >
                        PRIME_SEQUENCE_MAX_LENGTH.VALUE)
                {
                    Console.WriteLine("Cannot process request");

                    // Send reply indicating error
                    PrimeNumberReply errorReply = new PrimeNumberReply();
                    errorReply.status = PrimeNumberCalculationStatus.REPLY_ERROR;

                    replier.SendReply(errorReply, request.Identity);
                }
                else
                {
                    Console.WriteLine("Calculating prime numbers below " +
                            request.Data.n + "... ");

                    CalculateAndSendPrimes(request);

                    Console.WriteLine("DONE");
                }
            }

            Console.WriteLine(
                "No requests received for " + MAX_WAIT.sec +
                " seconds. Shutting down replier");
        }

        private void CalculateAndSendPrimes(
                Sample<PrimeNumberRequest> relatedRequest)
        {

            int n = relatedRequest.Data.n;
            int primesPerReply = relatedRequest.Data.primes_per_reply;

            List<bool> prime = new List<bool>(n + 1);
            for (int i = 0; i < n + 1; i++)
            {
                prime.Add(true);
            }

            prime[0] = false;
            prime[1] = false;

            int m = (int)Math.Sqrt(n);

            PrimeNumberReply reply = new PrimeNumberReply();
            reply.primes.maximum = primesPerReply;
            reply.status = PrimeNumberCalculationStatus.REPLY_IN_PROGRESS;

            for (int i = 2; i <= m; i++)
            {
                if (prime[i])
                {
                    for (int k = i * i; k <= n; k += i)
                    {
                        prime[k] = false;
                    }

                    // Add a new element
                    reply.primes.length++;
                    reply.primes.set_at(reply.primes.length - 1, i);

                    if (reply.primes.length == primesPerReply)
                    {
                        // Send a reply now
                        replier.SendReply(reply, relatedRequest.Identity);
                        reply.primes.length = 0;
                    }
                }
            }

            // Calculation is done. Send remaining prime numbers
            for (int i = m + 1; i <= n; i++)
            {
                if (prime[i])
                {
                    reply.primes.length++;
                    reply.primes.set_at(reply.primes.length - 1, i);
                    if (reply.primes.length == primesPerReply)
                    {
                        // Send a reply now
                        replier.SendReply(reply, relatedRequest.Identity);
                        reply.primes.length = 0;
                    }
                }
            }

            // Send the last reply. Indicate that the calculation is complete
            // and send any prime number left in the sequence
            reply.status = PrimeNumberCalculationStatus.REPLY_COMPLETED;
            replier.SendReply(reply, relatedRequest.Identity);
        }        

        // --- Application execution: -----------------------------------------

        public static void Main(string[] args)
        {
            int domainId = 0;


            if (args.Length > 0)
            {
                try
                {
                    domainId = Int32.Parse(args[0]);
                }
                catch (FormatException)
                {
                    Console.WriteLine("Invalid domain id");
                    return;
                }
            }


            /* Uncomment this to turn on additional logging
             NDDS.ConfigLogger.get_instance().set_verbosity(
                NDDS.LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_WARNING);             
             */

            Console.WriteLine(
                "PrimeNumberReplier running (on domain " + domainId +")");

            // Run the example
            using (PrimeNumberReplier primeNumberReplier =
                    new PrimeNumberReplier(domainId))
            {
                try
                {
                    primeNumberReplier.RunReplier();
                }
                catch (System.Exception ex)
                {
                    Console.WriteLine("Exception: " + ex.Message);
                }
            }
        }
    }
}
