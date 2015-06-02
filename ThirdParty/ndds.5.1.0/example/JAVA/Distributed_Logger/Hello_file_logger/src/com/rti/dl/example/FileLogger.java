/* $Id: FileLogger.java,v 1.5 2013/11/19 12:21:18 sara Exp $

   (c) Copyright, Real-Time Innovations, $Date: 2013/11/19 12:21:18 $.
   All rights reserved.

   No duplications, whole or partial, manual or electronic, may be made
   without express written permission.  Any such copies, or
   revisions thereof, must display this notice unaltered.
   This code contains trade secrets of Real-Time Innovations, Inc.
   
modification history:
--------------------- 
10a,05oct2011,krb  Added standard header.
=========================================================================== */

package com.rti.dl.example;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.domain.DomainParticipantFactoryQos;
import com.rti.dds.domain.DomainParticipantQos;
import com.rti.dds.infrastructure.DurabilityQosPolicyKind;
import com.rti.dds.infrastructure.HistoryQosPolicyKind;
import com.rti.dds.infrastructure.RETCODE_ERROR;
import com.rti.dds.infrastructure.RETCODE_NO_DATA;
import com.rti.dds.infrastructure.ReliabilityQosPolicyKind;
import com.rti.dds.infrastructure.ResourceLimitsQosPolicy;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.infrastructure.TransportBuiltinKind;
import com.rti.dds.subscription.DataReader;
import com.rti.dds.subscription.DataReaderListener;
import com.rti.dds.subscription.DataReaderQos;
import com.rti.dds.subscription.InstanceStateKind;
import com.rti.dds.subscription.LivelinessChangedStatus;
import com.rti.dds.subscription.RequestedDeadlineMissedStatus;
import com.rti.dds.subscription.RequestedIncompatibleQosStatus;
import com.rti.dds.subscription.SampleInfo;
import com.rti.dds.subscription.SampleInfoSeq;
import com.rti.dds.subscription.SampleLostStatus;
import com.rti.dds.subscription.SampleRejectedStatus;
import com.rti.dds.subscription.SampleStateKind;
import com.rti.dds.subscription.Subscriber;
import com.rti.dds.subscription.SubscriptionMatchedStatus;
import com.rti.dds.subscription.ViewStateKind;
import com.rti.dds.topic.Topic;
import com.rti.dl.DEBUG_LEVEL;
import com.rti.dl.DEFAULT_LOG_TOPIC_NAME;
import com.rti.dl.ERROR_LEVEL;
import com.rti.dl.FATAL_LEVEL;
import com.rti.dl.INFO_LEVEL;
import com.rti.dl.LOG_MESSAGE_TYPE_NAME;
import com.rti.dl.LogMessage;
import com.rti.dl.LogMessageDataReader;
import com.rti.dl.LogMessageSeq;
import com.rti.dl.LogMessageTypeSupport;
import com.rti.dl.NOTICE_LEVEL;
import com.rti.dl.SEVERE_LEVEL;
import com.rti.dl.SILENT_LEVEL;
import com.rti.dl.TRACE_LEVEL;
import com.rti.dl.WARNING_LEVEL;
import com.rti.ndds.config.LogVerbosity;
import com.rti.ndds.config.Logger;

/**
 * This class provides a simple mechanism to subscribe to the Distributed
 * Logger's log message topic and write the data out to a file. Multiple domains
 * can be joined through the command line.
 * @author RTI
 */
public class FileLogger {
    
    public static final String FIELD_SEPARATOR = ", ";
    public static final DateFormat dateFormat = 
        new SimpleDateFormat("MM/dd/yyyy hh:mm:ss SSS aa");
    
    private boolean isShuttingDown;
    private final List<DomainParticipant> domainParticipants;
    private final BufferedWriter writer;
    
    public FileLogger(String outputFilePath) throws IOException {
        isShuttingDown = false;
        domainParticipants = new LinkedList<DomainParticipant>();
        writer = new BufferedWriter(new FileWriter(outputFilePath));
        
        writeHeader();
    }
    
    private void writeHeader() throws IOException {
        writer.write("Host Id (hex)");
        writer.write(FIELD_SEPARATOR);
        writer.write("App Id (hex)");
        writer.write(FIELD_SEPARATOR);
        writer.write("Writer sequence number");
        writer.write(FIELD_SEPARATOR);
        writer.write("Timestamp");
        writer.write(FIELD_SEPARATOR);
        writer.write("Level");
        writer.write(FIELD_SEPARATOR);
        writer.write("Category");
        writer.write(FIELD_SEPARATOR);
        writer.write("Message");
        writer.write(FIELD_SEPARATOR);
        writer.write("\n");
    }
    
    public boolean joinDomain(int domainId) {
        DomainParticipantQos participantQos = new DomainParticipantQos();
        DomainParticipantFactory.get_instance().get_default_participant_qos(
                participantQos);
        participantQos.participant_name.name = "File Logger";
        DomainParticipant domainParticipant = null;
        try {
            domainParticipant = 
                DomainParticipantFactory.get_instance().create_participant(
                    domainId, 
                    participantQos,
                    null, StatusKind.STATUS_MASK_NONE);
        } catch(RETCODE_ERROR error) {
            // see if we can still create the participant without using the UDP
            // transport (this happens often when running the software on an
            // unconnected laptop)
            participantQos.transport_builtin.mask = TransportBuiltinKind.SHMEM;
            domainParticipant = 
                DomainParticipantFactory.get_instance().create_participant(
                    domainId, 
                    participantQos,
                    null, StatusKind.STATUS_MASK_NONE);
        }
        
        if (domainParticipant == null) {
            return false;
        }
        
        // ensure to use the constant for the type name, not the one from the
        // support class
        domainParticipant.register_type(
                LOG_MESSAGE_TYPE_NAME.VALUE, 
                LogMessageTypeSupport.get_instance(), null);
        
        Topic logMessageTopic = domainParticipant.create_topic(
                DEFAULT_LOG_TOPIC_NAME.VALUE, 
                // be sure not to use LogMessageTypeSupport.get_type_name()
                // here since that won't agree with the type name registered by
                // the library
                LOG_MESSAGE_TYPE_NAME.VALUE,
                DomainParticipant.TOPIC_QOS_DEFAULT,
                null, StatusKind.STATUS_MASK_NONE);
        
        if (logMessageTopic == null) {
            deleteParticipant(domainParticipant);
            return false;
        }
        
        Subscriber subscriber = domainParticipant.create_subscriber(
                DomainParticipant.SUBSCRIBER_QOS_DEFAULT, 
                null, StatusKind.STATUS_MASK_NONE);
        
        if (subscriber == null) {
            deleteParticipant(domainParticipant);
            return false;
        }
        
        DataReaderQos readerQos = new DataReaderQos();
        subscriber.get_default_datareader_qos(readerQos);
        readerQos.reliability.kind = 
            ReliabilityQosPolicyKind.RELIABLE_RELIABILITY_QOS;
        readerQos.durability.kind = 
            DurabilityQosPolicyKind.TRANSIENT_LOCAL_DURABILITY_QOS;
        readerQos.history.kind = 
            HistoryQosPolicyKind.KEEP_LAST_HISTORY_QOS;
        readerQos.history.depth = 10;
        
        LogDataReaderListener listener = new LogDataReaderListener();
        
        // NOTE: Often it is a bad idea to attach a listener directly to the
        // reader which will execute code directly in the on_data_available()
        // routine since this will block the middleware receive thread from
        // processing incoming data. In this case, the whole purpose of this
        // application is to store the incoming messages to a file and no other
        // logic is being performed (and no other readers are sharing the 
        // receive thread with this reader). Given these conditions, it is not
        // a problem to keep this thread busy since there are no other actions
        // it could/should be doing.
        LogMessageDataReader reader = (LogMessageDataReader) 
            subscriber.create_datareader(logMessageTopic, readerQos, 
                    listener, StatusKind.STATUS_MASK_ALL);
        
        if (reader == null) {
            deleteParticipant(domainParticipant);
            return false;
        }
        
        // now that we've successfully gotten to this point, we can store the
        // domain participant for later use
        domainParticipants.add(domainParticipant);
        
        return true;
    }
    
    /**
     * Write a log message out to the file.
     * @param logMessage The message to be written.
     * @param sampleInfo The sample information that goes with the message.
     */
    private void writeLogMessage(LogMessage logMessage, SampleInfo sampleInfo) {
        if (isShuttingDown) {
            return;
        }
        try {
            // write the host id
            writer.write("0x");
            writer.write(Integer.toHexString(
                    logMessage.hostAndAppId.rtps_host_id));
            writer.write(FIELD_SEPARATOR);

            // write the app id
            writer.write("0x");
            writer.write(Integer.toHexString(
                    logMessage.hostAndAppId.rtps_app_id));
            writer.write(FIELD_SEPARATOR);

            // convert the fields to strings
            writer.write(sequenceNumberToBigInteger(
                    sampleInfo.publication_sequence_number.high,
                    sampleInfo.publication_sequence_number.low).toString());
            writer.write(FIELD_SEPARATOR);
            
            // capture the date/time information
            long date = sampleInfo.source_timestamp.sec;
            // convert to milliseconds
            date *= 1000;
            // add in the nanoseconds (converted to milliseconds)
            date += (sampleInfo.source_timestamp.nanosec / 1000);
            writer.write(dateFormat.format(new Date(date)));
            writer.write(FIELD_SEPARATOR);

            writer.write(levelToString(logMessage.level));
            writer.write(FIELD_SEPARATOR);

            writer.write(logMessage.category);
            writer.write(FIELD_SEPARATOR);

            writer.write(logMessage.message.trim());
            writer.write("\n");

        } catch(IOException ioe) {
            System.err.println("trouble writing a log message...stack " +
            "trace to follow");
            ioe.printStackTrace(System.err);
        }
    }
    
    public static BigInteger sequenceNumberToBigInteger(int high, long low) {
        // need to convert to a 64-bit representation
        // converting the integer to a string isn't very efficient but I don't
        // see a suitable constructor anywhere in BigInteger
        BigInteger bigInteger = new BigInteger(Integer.toString(high));
        bigInteger = bigInteger.shiftLeft(32);
        bigInteger = bigInteger.add(BigInteger.valueOf(low));
        return bigInteger;
    }
    
    public static String levelToString(int level) {
        String value = String.valueOf(level);
        switch(level) {
            case SILENT_LEVEL.VALUE:
                value = "Silent";
                break;
                
            case FATAL_LEVEL.VALUE:
                value = "Fatal";
                break;
                
            case SEVERE_LEVEL.VALUE:
                value = "Severe";
                break;
                
            case ERROR_LEVEL.VALUE:
                value = "Error";
                break;
                
            case WARNING_LEVEL.VALUE:
                value = "Warning";
                break;
                
            case NOTICE_LEVEL.VALUE:
                value = "Notice";
                break;
                
            case INFO_LEVEL.VALUE:
                value = "Info";
                break;
                
            case DEBUG_LEVEL.VALUE:
                value = "Debug";
                break;
                
            case TRACE_LEVEL.VALUE:
                value = "Trace";
                break;
        }
        
        return value;
    }
    
    private class LogDataReaderListener implements DataReaderListener {

        @Override
        public synchronized void on_data_available(DataReader reader) {
            // take all data out and push it to the file
            LogMessageSeq dataSeq = new LogMessageSeq();
            SampleInfoSeq infoSeq = new SampleInfoSeq();
            LogMessageDataReader logMessageReader = 
                (LogMessageDataReader) reader;
            
            boolean moreData = true;
            do {

                try {
                    logMessageReader.take(
                            dataSeq, infoSeq,
                            ResourceLimitsQosPolicy.LENGTH_UNLIMITED,
                            SampleStateKind.ANY_SAMPLE_STATE,
                            ViewStateKind.ANY_VIEW_STATE,
                            InstanceStateKind.ANY_INSTANCE_STATE);

                    for(int i = 0; i < dataSeq.size(); ++i) {
                        SampleInfo sampleInfo = (SampleInfo) infoSeq.get(i);
                        if (sampleInfo.valid_data) {
                            writeLogMessage((LogMessage) dataSeq.get(i), 
                                    sampleInfo);
                        }
                    }
                    
                } catch (RETCODE_NO_DATA noData) {
                    // No data to process
                    moreData = false;

                } finally {
                    logMessageReader.return_loan(dataSeq, infoSeq);
                }
            } while(moreData);
        }

        @Override
        public synchronized void on_liveliness_changed(DataReader reader,
                LivelinessChangedStatus status) {
            System.out.println("FileLogger: liveliness changed in domain : " + 
                    reader.get_subscriber().get_participant().get_domain_id() +
                    " : status : " + status);
        }

        @Override
        public synchronized void on_requested_deadline_missed(DataReader reader,
                RequestedDeadlineMissedStatus status) {
            System.err.println("FileLogger: deadline(s) missed in domain : " + 
                    reader.get_subscriber().get_participant().get_domain_id() +
                    " : status : " + status);
        }

        @Override
        public synchronized void on_requested_incompatible_qos(
                DataReader reader, RequestedIncompatibleQosStatus status) {
            System.err.println("FileLogger: incompatible QoS in domain : " + 
                    reader.get_subscriber().get_participant().get_domain_id() +
                    " : status : " + status);
        }

        @Override
        public synchronized void on_sample_lost(DataReader reader, 
                SampleLostStatus status) {
            System.err.println("FileLogger: sample(s) lost in domain : " + 
                    reader.get_subscriber().get_participant().get_domain_id() +
                    " : status : " + status);
        }

        @Override
        public synchronized void on_sample_rejected(DataReader reader,
                SampleRejectedStatus status) {
            System.err.println("FileLogger: sample rejected in domain : " + 
                    reader.get_subscriber().get_participant().get_domain_id() +
                    " : status : " + status);
        }

        @Override
        public synchronized void on_subscription_matched(DataReader reader,
                SubscriptionMatchedStatus status) {
            System.out.println("FileLogger: subscription matched in domain : " + 
                    reader.get_subscriber().get_participant().get_domain_id() +
                    " : status : " + status);
        }
        
    }
    
    public synchronized boolean shutdown() {
        boolean success = true;
        isShuttingDown = true;
        if (writer != null) {
            try {
                writer.flush();
                writer.close();
            } catch(IOException ioe) {
                // not much we can do about this
            }
        }
        
        for(DomainParticipant domainParticipant : domainParticipants) {
            if (!deleteParticipant(domainParticipant)) {
                success = false;
            }
        }
        return success;
    }
    
    private static boolean deleteParticipant(
            DomainParticipant domainParticipant) {
        if (domainParticipant == null) {
            return true;
        }
        
        boolean success = false;
        
        try {
            System.out.println("FileLogger: shutting down domain id : " + 
                    domainParticipant.get_domain_id());
            domainParticipant.delete_contained_entities();
            DomainParticipantFactory.get_instance().delete_participant(
                    domainParticipant);
            success = true;
            
        } catch(RETCODE_ERROR error) {
            System.err.println("FileLogger: trouble deleting participant");
            error.printStackTrace();
        }
        
        return success;
    }
    
    /**
     * @param args
     */
    public static void main(String[] args) {
        // turn DDS warnings on
        Logger.get_instance().set_verbosity(
                LogVerbosity.NDDS_CONFIG_LOG_VERBOSITY_WARNING);
        
        String outputFilePath = "log_messages.txt";
        SortedSet<Integer> domainIds = new TreeSet<Integer>();
        
        // if no domains were specified, use domain 0
        if (args == null || args.length == 0) {
            
            domainIds.add(0); //Change here the domain ID
            
        } else {
            // parse out all of the args
            for(int i = 0; i < args.length; i++) {
                try {
                    domainIds.add(Integer.parseInt(args[i]));
                    
                } catch(NumberFormatException nfe) {
                    // if it wasn't an integer, treat it as an output file path
                    outputFilePath = args[i];
                }
            }
        }
        System.out.println("FileLogger: attempting to start logging to " +
        		"file : " + outputFilePath);
        
        try {
            final FileLogger fileLogger = new FileLogger(outputFilePath);
            
            Runtime.getRuntime().addShutdownHook(new Thread() {
                public void run() {
                    System.out.println("FileLogger: running shutdown " +
                    		"routine...");
                    if (!fileLogger.shutdown()) {
                        // force the exit since there was an issue during 
                        // shutdown
                        System.exit(-1);
                    } else {
                        DomainParticipantFactory.finalize_instance();
                    }
                }
            });
            
            // if there are many domains, increase the max objects per thread
            if (domainIds.size() > 5) {
                DomainParticipantFactoryQos factoryQos = 
                    new DomainParticipantFactoryQos();
                DomainParticipantFactory.get_instance().get_qos(factoryQos);
                factoryQos.resource_limits.max_objects_per_thread = 
                    factoryQos.resource_limits.max_objects_per_thread 
                    * (int) Math.ceil((domainIds.size() / 5.0));
                DomainParticipantFactory.get_instance().set_qos(factoryQos);
            }
            
            for(int domainId : domainIds) {
                System.out.println("FileLogger: attempting to join domain " +
                        "id : " + domainId);
                fileLogger.joinDomain(domainId);
            }
            
        } catch(Exception e) {
            e.printStackTrace(System.err);
            System.exit(-1);
        }
    }

}
