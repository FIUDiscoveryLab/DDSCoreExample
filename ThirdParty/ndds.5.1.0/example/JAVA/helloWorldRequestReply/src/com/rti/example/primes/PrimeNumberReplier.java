// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************

package com.rti.example.primes;

import java.util.ArrayList;
import java.util.Collections;

import com.rti.connext.infrastructure.Sample;
import com.rti.connext.requestreply.Replier;
import com.rti.connext.requestreply.ReplierParams;
import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.infrastructure.Duration_t;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.example.primes.idl.PRIME_SEQUENCE_MAX_LENGTH;
import com.rti.example.primes.idl.PrimeNumberCalculationStatus;
import com.rti.example.primes.idl.PrimeNumberReply;
import com.rti.example.primes.idl.PrimeNumberReplyTypeSupport;
import com.rti.example.primes.idl.PrimeNumberRequest;
import com.rti.example.primes.idl.PrimeNumberRequestTypeSupport;

public class PrimeNumberReplier {
    
    private DomainParticipant participant;
    private Replier<PrimeNumberRequest, PrimeNumberReply> replier;
    
    private final static Duration_t MAX_WAIT = new Duration_t(120, 0);
    
    public PrimeNumberReplier(int domainId) {
        
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
        replier = new Replier<PrimeNumberRequest, PrimeNumberReply>(
                new ReplierParams<PrimeNumberRequest, PrimeNumberReply>(
                    participant, 
                    PrimeNumberRequestTypeSupport.get_instance(), 
                    PrimeNumberReplyTypeSupport.get_instance())
                    .setServiceName("PrimeCalculator")
                    .setQosProfile("RequestReplyExampleProfiles", 
                            "ReplierExampleProfile"));
    }

    public void runReplier() {
        Sample<PrimeNumberRequest> request = replier.createRequestSample();
        
        while(replier.receiveRequest(request, MAX_WAIT)) {
            
            if (!request.getInfo().valid_data) {
                continue;
            }
            
            // This constant is defined in Primes.idl
            if (request.getData().n <= 0 ||
                request.getData().primes_per_reply <= 0 ||
                request.getData().primes_per_reply > 
                    PRIME_SEQUENCE_MAX_LENGTH.VALUE) {
                System.out.println("Cannot process request");
                
                // Send reply indicating error
                PrimeNumberReply errorReply = new PrimeNumberReply();
                errorReply.status = PrimeNumberCalculationStatus.REPLY_ERROR;
                
                replier.sendReply(errorReply, request.getIdentity());
            } else {
                System.out.println("Calculating prime numbers below "+
                        request.getData().n+"... ");

                calculateAndSendPrimes(request);
                
                System.out.println("DONE");
            }
        }
        
        System.out.println(
                "No requests received for " + MAX_WAIT.sec + 
                " seconds. Shutting down replier");
    }
    
    private void calculateAndSendPrimes(
            Sample<PrimeNumberRequest> relatedRequest) {
        
        int n = relatedRequest.getData().n;
        int primesPerReply = relatedRequest.getData().primes_per_reply;
        
        ArrayList<Boolean> prime = new ArrayList<Boolean>(n+1);
        prime.addAll(Collections.nCopies(n+1, true));
        
        prime.set(0, false);
        prime.set(1, false);
        
        int m = (int) Math.sqrt(n);
        
        PrimeNumberReply reply = new PrimeNumberReply();
        reply.primes.setMaximum(primesPerReply);
        reply.status = PrimeNumberCalculationStatus.REPLY_IN_PROGRESS;
        
        for (int i = 2; i <= m; i++) {
            if (prime.get(i)) {
                for (int k = i*i; k <= n; k+=i) {
                    prime.set(k, false);
                }
                
                // Add a new element
                reply.primes.add(i);
                
                if (reply.primes.size() == primesPerReply) {
                    // Send a reply now
                    replier.sendReply(reply, relatedRequest.getIdentity());
                    reply.primes.clear();
                }
            }
        }
                
        // Calculation is done. Send remaining prime numbers
        for (int i = m + 1; i <= n; i++) {
            if (prime.get(i)) {
                reply.primes.add(i);
                if (reply.primes.size() == primesPerReply) {
                    // Send a reply now
                    replier.sendReply(reply, relatedRequest.getIdentity());
                    reply.primes.clear();                    
                }
            }
        }
        
        // Send the last reply. Indicate that the calculation is complete
        // and send any prime number left in the sequence
        reply.status = PrimeNumberCalculationStatus.REPLY_COMPLETED;
        replier.sendReply(reply, relatedRequest.getIdentity());
    }
    
    // ------------------------------------------------------------------------
    
    public void close() {
        if (replier != null) {
            replier.close();
            replier = null;
        }
        
        
        if (participant != null) {
            participant.delete_contained_entities();
                DomainParticipantFactory.get_instance()
                    .delete_participant(participant);
            participant = null;
        }
    }

    // ------------------------------------------------------------------------
    
    public static void main(String[] args) {

        int domainId = 0;
        
        // Parse arguments
        if (args.length > 0) {
            try {
                domainId = Integer.parseInt(args[0]);
            } catch (NumberFormatException ex) {
                System.out.println("Invalid domain id");
                return;
            }
        }
        
        /* Uncomment this to turn on additional logging
        com.rti.ndds.config.Logger.get_instance().set_verbosity(
            com.rti.ndds.config.LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_WARNING);
         */
        
        System.out.println(
                "PrimeNumberReplier running (on domain " + domainId +")");        
        
        // Run the example
        PrimeNumberReplier primeNumberReplier = 
                new PrimeNumberReplier(domainId);        
        try {
            primeNumberReplier.runReplier();
        } finally {
            primeNumberReplier.close();
        }
    }
}
