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
    class PrimeNumberRequester : IDisposable
    {
        // --- Members: -------------------------------------------------------

        private DomainParticipant participant;
        private Requester<PrimeNumberRequest, PrimeNumberReply> requester;

        // --- Constructor: ---------------------------------------------------

        public PrimeNumberRequester(int domainId)
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

            // Create replier with that participant and:
            // - The DDS TypeSupport for the request and reply types
            // - A service name
            // - (Optionally) a QoS profile, in USER_QOS_PROFILES.xml
            requester = new Requester<PrimeNumberRequest, PrimeNumberReply>(
                    new RequesterParams(
                        participant,
                        PrimeNumberRequestTypeSupport.get_instance(),
                        PrimeNumberReplyTypeSupport.get_instance())
                    .SetServiceName("PrimeCalculator")
                    .SetQosProfile("RequestReplyExampleProfiles",
                            "RequesterExampleProfile")
            );
        }

        // --- Dispose: -------------------------------------------------------

        public void Dispose()
        {
            if (requester != null)
            {
                requester.Dispose();
                requester = null;
            }

            if (participant != null)
            {
                participant.delete_contained_entities();
                DomainParticipantFactory.get_instance().
                    delete_participant(ref participant);
                participant = null;
            }
        }

        // --- Run requester: -------------------------------------------------

        public void PrintPrimeNumbers(int n, int primesPerReply)
        {
                
            Duration_t MAX_WAIT = new Duration_t();
            MAX_WAIT.sec = 20;
            MAX_WAIT.nanosec = 0;

            // Create a request sample
            WriteSample<PrimeNumberRequest> request =
                requester.CreateRequestSample();

            request.Data.n = n;
            request.Data.primes_per_reply = primesPerReply;

            //
            // Send the request
            //
            requester.SendRequest(request);

            bool inProgress = true;
            while (inProgress)
            {
                //
                // Receive replies (one or more at a time)
                //
                // We read a collection of loaned samples that
                // is returned (Disposed) to the middleware
                // when the application exits the using block.
                //
                using (LoanedSamples<PrimeNumberReply> replies =
                        requester.ReceiveReplies(MAX_WAIT))
                {

                    if (replies.Count == 0)
                    {
                        // The Requester doesn't report a timeouts as exceptions
                        // but as a empty collection instead.
                        throw new TimeoutException(
                            "Timed out waiting for replies");
                    }

                    // Iterate through the sample collection
                    foreach (Sample<PrimeNumberReply> reply in replies)
                    {
                        if (!reply.Info.valid_data)
                        {
                            continue;
                        }

                        // Print the prime numbers we receive
                        for (int i = 0; i < reply.Data.primes.length; i++)
                        {
                            int prime = reply.Data.primes.get_at(i);
                            Console.Write(prime + " ");
                        }

                        if (reply.Data.status !=
                                PrimeNumberCalculationStatus.REPLY_IN_PROGRESS)
                        {
                            inProgress = false;
                            if (reply.Data.status ==
                                    PrimeNumberCalculationStatus.REPLY_ERROR)
                            {
                                throw new SystemException("Error in Replier");
                            }
                            else
                            { // status == COMPLETED
                                Console.WriteLine("DONE");
                            }
                        }
                        Console.WriteLine();
                    }
                }
            }
        }

        // --- Application execution: -----------------------------------------

        private static void PrintFormat()
        {
            Console.WriteLine("PrimeNumberRequester");
            Console.WriteLine(
                "Sends a request to calculate the prime numbers <= n");
            Console.WriteLine(
                "Parameters: <n> [<primes_per_reply>=5] [<domain_id>=0]");
        }

        public static void Main(string[] args)
        {
            int n;
            int primesPerReply = 5;
            int domainId = 0;

            // Parse arguments
            if (args.Length == 0)
            {
                PrintFormat();
                return;
            }

            try
            {
                n = Int32.Parse(args[0]);
            }
            catch (FormatException)
            {
                Console.WriteLine(
                    "First argument, n, must be a positive integer");
                PrintFormat();
                return;
            }

            if (args.Length > 1)
            {
                try
                {
                    primesPerReply = Int32.Parse(args[1]);
                }
                catch (FormatException)
                {
                    Console.WriteLine("Invalid domain id");
                    PrintFormat();
                    return;
                }
            }

            if (args.Length > 2)
            {
                try
                {
                    domainId = Int32.Parse(args[2]);
                }
                catch (FormatException)
                {
                    Console.WriteLine("Invalid domain id");
                    PrintFormat();
                    return;
                }
            }

            /* Uncomment this to turn on additional logging
             NDDS.ConfigLogger.get_instance().set_verbosity(
                NDDS.LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_WARNING);             
             */

            Console.WriteLine(
                "PrimeNumberRequester: Sending a request to calculate the " +
                "prime numbers <= " + n + " in sequences of " + primesPerReply +
                " or less elements (on domain " + domainId + ")");

            // Run the example
            using (PrimeNumberRequester primeNumberReplier =
                    new PrimeNumberRequester(domainId))
            {
                try
                {
                    primeNumberReplier.PrintPrimeNumbers(n, primesPerReply);
                }
                catch (System.Exception ex)
                {
                    Console.WriteLine("Exception: " + ex.Message);
                }
            }
        }
    }
}
