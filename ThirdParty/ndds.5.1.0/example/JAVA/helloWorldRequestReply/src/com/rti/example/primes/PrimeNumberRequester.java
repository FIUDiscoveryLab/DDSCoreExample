// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.example.primes;

import java.util.concurrent.TimeoutException;

import com.rti.connext.infrastructure.Sample;
import com.rti.connext.infrastructure.WriteSample;
import com.rti.connext.requestreply.Requester;
import com.rti.connext.requestreply.RequesterParams;
import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.infrastructure.Duration_t;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.example.primes.idl.PrimeNumberCalculationStatus;
import com.rti.example.primes.idl.PrimeNumberReply;
import com.rti.example.primes.idl.PrimeNumberReplyTypeSupport;
import com.rti.example.primes.idl.PrimeNumberRequest;
import com.rti.example.primes.idl.PrimeNumberRequestTypeSupport;

public class PrimeNumberRequester {
    
    private DomainParticipant participant;
    private Requester<PrimeNumberRequest, PrimeNumberReply> requester;
    
    private final static Duration_t MAX_WAIT = new Duration_t(20, 0);
    
    public PrimeNumberRequester(int domainId) {
        
        // Create participant
        participant = DomainParticipantFactory.get_instance()
                .create_participant(
                        domainId, 
                        DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT, 
                        null, StatusKind.STATUS_MASK_NONE);
        
        if (participant == null) {
            throw new RuntimeException("Participant creation failed");
        }

        // Create replier with that participant
        requester = new Requester<PrimeNumberRequest, PrimeNumberReply>(
                new RequesterParams(
                    participant, 
                    // The DDS TypeSupport for the request and reply types
                    PrimeNumberRequestTypeSupport.get_instance(), 
                    PrimeNumberReplyTypeSupport.get_instance())
                    // Same service name in Requester and Replier
                    .setServiceName("PrimeCalculator")
                    // QoS profiles defined in USER_QOS_PROFILES.xml
                    .setQosProfile("RequestReplyExampleProfiles", 
                            "RequesterExampleProfile"));
    }

    /**
     * 
     * @param n
     * @return The list of primes <= n
     * @throws TimeoutException If no prime numbers are received for the
     *         duration indicated by MAX_WAIT
     * @throws NumberFormatException If any of the received prime numbers
     *         is not a valid integer (except for the empty string that
     *         indicates the end of the sequence of primes)
     */
    public void printPrimeNumbers(int n, int primesPerReply) 
            throws TimeoutException {
        
        // Create a request sample
        WriteSample<PrimeNumberRequest> request = 
                requester.createRequestSample();
        
        request.getData().n = n;
        request.getData().primes_per_reply = primesPerReply;
        
        //
        // Send the request
        //
        requester.sendRequest(request);
        
        boolean inProgress = true;
        while(inProgress) {
          
            //
            // Receive replies (one or more at a time)
            // The iterator can access a loaned list of samples
            //
            Sample.Iterator<PrimeNumberReply> replies = 
                    requester.receiveReplies(MAX_WAIT);
            
            // When receiveReplies times out, 
            // it returns an empty reply collection
            if (!replies.hasNext()) {
                throw new TimeoutException("Timed out waiting for replies");
            }
            
            try {
                do { // Iterate through the sample list
                    Sample<PrimeNumberReply> reply = replies.next();
                    if (reply.getInfo().valid_data) {
                        
                        // Print the prime numbers we receive
                        for(Object primeObj : reply.getData().primes) {
                            int prime = (Integer) primeObj;
                            System.out.print(prime + " ");
                        }
                        
                        if (reply.getData().status != 
                                PrimeNumberCalculationStatus.REPLY_IN_PROGRESS){
                            inProgress = false;
                            if (reply.getData().status ==
                                    PrimeNumberCalculationStatus.REPLY_ERROR) {
                                throw new RuntimeException("Error in replier");
                            } else { // reply->status == COMPLETED
                                System.out.println("DONE");
                            }
                        }
                        
                        System.out.println();
                    }
                } while (replies.hasNext());

            } finally {
                // Return loaned samples
                // Tip: In Java 7, consider using a try-with-resources block
                replies.close(); 
            }
        }
    }
    
    // ------------------------------------------------------------------------
    
    private static void printFormat() {
        System.out.println("PrimeNumberRequester");
        System.out.println("Sends a request to calculate the prime numbers <= n");
        System.out.println("Parameters: <n> [<primes_per_reply>=5] [<domain_id>=0]");
    }

    // ------------------------------------------------------------------------
    
    public void close() {
        if (requester != null) {
            requester.close();
            requester = null;
        }
        
        if (participant != null) {
            participant.delete_contained_entities();
                DomainParticipantFactory.get_instance()
                    .delete_participant(participant);
            participant = null;
        }

    }
    
    // ------------------------------------------------------------------------
    
    public static void main(String[] args) throws TimeoutException {

        int n;
        int primesPerReply = 5;
        int domainId = 0;
        
        // Parse arguments
        if (args.length == 0) {
            printFormat();
            return;
        }
        
        try {
            n = Integer.parseInt(args[0]);
        } catch (NumberFormatException ex) {
            System.out.println("First argument, n, must be a positive integer");
            printFormat();
            return;
        }
        
        if (args.length > 1) {
            try {
                primesPerReply = Integer.parseInt(args[1]);
            } catch (NumberFormatException ex) {
                System.out.println("Invalid domain id");
                printFormat();
                return;
            }
        }
        
        if (args.length > 2) {
            try {
                domainId = Integer.parseInt(args[2]);
            } catch (NumberFormatException ex) {
                System.out.println("Invalid domain id");
                printFormat();
                return;
            }
        }
        
        /* Uncomment this to turn on additional logging
        com.rti.ndds.config.Logger.get_instance().set_verbosity(
            com.rti.ndds.config.LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_WARNING);
         */
        
        System.out.println(
            "PrimeNumberRequester: Sending a request to calculate the " +
            "prime numbers <= " + n + " in sequences of " + primesPerReply +
            " or less elements (on domain " + domainId + ")");     
        
        // Run the example
        PrimeNumberRequester primeNumberReplier = 
                new PrimeNumberRequester(domainId);
        try {
            primeNumberReplier.printPrimeNumbers(n, primesPerReply);
        } finally {
            primeNumberReplier.close();
        }
    }    
}
