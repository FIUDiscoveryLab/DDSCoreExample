// ****************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.       
//                                                                          
//         Permission to modify and use for internal purposes granted.      
// This software is provided "as is", without warranty, express or implied. 
//                                                                          
// ****************************************************************************
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.domain.DomainParticipantFactory;
import com.rti.dds.domain.DomainParticipantFactoryQos;
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.infrastructure.RETCODE_ERROR;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.publication.Publisher;
import com.rti.dds.topic.Topic;
import com.rti.dds.type.builtin.StringDataWriter;
import com.rti.dds.type.builtin.StringTypeSupport;

import com.rti.dds.subscription.Subscriber;
//****************************************************************************
public class HelloPublisher {
    public static final void main(String[] args) {
    	
    	List<String> fileNames = new ArrayList<String>();
        //BufferedReader reader = new BufferedReader(new FileReader(Config.QOS_FILE_PATH));
        //filenames.add("base_profile_multicast.xml");
        //filenames.add("MaxMulticast.xml");
    	fileNames.add("MaxMulticast.xml");
    	
        // Create the DDS Domain participant on domain ID 0
		DomainParticipantFactoryQos factoryQos = 
				new DomainParticipantFactoryQos();
		DomainParticipantFactory.get_instance().get_qos(factoryQos);
		factoryQos.profile.url_profile.setMaximum(fileNames.size());
		for (int i = 0; i < fileNames.size(); i++) {
			
			factoryQos.profile.url_profile.add(fileNames.get(i));
		}

		DomainParticipantFactory.get_instance().set_qos(factoryQos);
		
		DomainParticipant participant = 
				DomainParticipantFactory.get_instance()
				.create_participant_with_profile(
									0,
									"BasicAEONProfile", 
									 "MaxThroughputMulticast", 
									null, 
									StatusKind.STATUS_MASK_NONE);
		
        /*
        DomainParticipant participant = DomainParticipantFactory.get_instance().create_participant(
                0, // Domain ID = 0
                DomainParticipantFactory.PARTICIPANT_QOS_DEFAULT, 
                null, // listener
                StatusKind.STATUS_MASK_NONE);
        */
        if (participant == null) {
            System.err.println("Unable to create domain participant");
            return;
        }

        // Create the topic "Hello World" for the String type
        Topic topic = participant.create_topic(
                "Hello, World", 
                StringTypeSupport.get_type_name(), 
                DomainParticipant.TOPIC_QOS_DEFAULT, 
                null, // listener
                StatusKind.STATUS_MASK_NONE);
        if (topic == null) {
            System.err.println("Unable to create topic.");
            return;
        }

        // Create the data writer using the default publisher
        StringDataWriter dataWriter =
            (StringDataWriter) participant.create_datawriter(
                topic, 
                Publisher.DATAWRITER_QOS_DEFAULT,
                null, // listener
                StatusKind.STATUS_MASK_NONE);
        if (dataWriter == null) {
            System.err.println("Unable to create data writer\n");
            return;
        }

        System.out.println("Ready to write data.");
        System.out.println("When the subscriber is ready, you can start writing.");
        System.out.print("Press CTRL+C to terminate or enter an empty line to do a clean shutdown.\n\n");

        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            while (true) {
                System.out.print("Please type a message> ");
                String toWrite = reader.readLine();
                if (toWrite == null) break;     // shouldn't happen
                dataWriter.write(toWrite, InstanceHandle_t.HANDLE_NIL);
                if (toWrite.equals("")) break;
            }
        } catch (IOException e) {
            // This exception can be thrown from the BufferedReader class
            e.printStackTrace();
        } catch (RETCODE_ERROR e) {
            // This exception can be thrown from DDS write operation
            e.printStackTrace();
        }

        System.out.println("Exiting...");
        participant.delete_contained_entities();
        DomainParticipantFactory.get_instance().delete_participant(participant);
    }
}
