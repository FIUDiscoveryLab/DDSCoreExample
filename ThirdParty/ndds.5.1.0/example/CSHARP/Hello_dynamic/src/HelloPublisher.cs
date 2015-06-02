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
using System.Text;

namespace Hello {
    /**
     * Manage the data publication for the Hello example 
     */
    class HelloPublisher {
        /* Maximum consecutive write error after stopping the write process */
        private const int MAX_CONSECUTIVE_WRITE_ERROR = 5;

        private DDS.DynamicDataWriter _theDataWriter;
        private DDS.DynamicData _theInstance;
        private int _theVerbose;
        private int _theSampleCount;

        
        // ************************************************************************
        /**
         * Builds a new HelloPublisher object and initialize the inner DDS 
         * entities.
         * This method only creates the entities, but it does not actually write
         * the data.
         * To write the data, use the method writeSamples().
         *  
         * @param participant the DDS Domain participant
         * @param topic       the DDS topic 
         * @param verbose     an integer to control the output verbosity
         * @param dataSize    the size of the payload data
         */

        public HelloPublisher(DDS.DomainParticipant participant,
                              DDS.Topic topic,
                              DDS.TypeCode typeCode,
                              int verbose,
                              int dataSize,
                              int sampleCount) {
            _theVerbose = verbose;
            _theSampleCount = sampleCount;

            /* Creates the DDS Data writer. 
             * Just like before, if you want to customize the writer QoS,
             * use DDS.Publisher.get_default_datawriter_qos() to 
             * initialize a local copy of the default QoS, modify them, then
             * use them in the creation call below instead of 
             * DDS_DATAWRITER_QOS_DEFAULT.
             * For more data writer API info, see:
             *     $NDDSHOME/doc/html/api_dotnet/group__DDSWriterModule.html
             */
            if (verbose > 0) {
                Console.WriteLine("Creating the data writer...");
            }
            _theDataWriter = (DDS.DynamicDataWriter)
                participant.create_datawriter(topic,
                            DDS.Publisher.DATAWRITER_QOS_DEFAULT,
                            null, /* Listener */
                            DDS.StatusMask.STATUS_MASK_NONE);
            if (_theDataWriter == null) {
                Console.Error.WriteLine("! Unable to create DDS data writer");
                return;
            }

            /* Creates an instance of the sparse data we are about to send
             */
            _theInstance = new DDS.DynamicData(typeCode, DDS.DynamicData.DYNAMIC_DATA_PROPERTY_DEFAULT);

            /* The DynamicDataType has been defined (in HelloWorldType.cxx) to hold
             * a structure like the following one:
             * struct HelloWorld {
             *     string<64>            prefix;
             *     long                  sampleId;
             *     sequence<octet, 8192> payload;
             * };
             */
            _theInstance.set_string("prefix",
                                DDS.DynamicData.MEMBER_ID_UNSPECIFIED,
                                "HelloWorld!");
            _theInstance.set_int("sampleId", DDS.DynamicData.MEMBER_ID_UNSPECIFIED,
                                0);
            
            DDS.ByteSeq byteSeq = new DDS.ByteSeq(dataSize);
            //byte[] payload = new byte[dataSize];
            for (int i = 0; i < dataSize; ++i) {
                byteSeq.buffer[i] = (byte)(i % 0xff);
            }
            
            _theInstance.set_byte_seq("payload",
                                DDS.DynamicData.MEMBER_ID_UNSPECIFIED,
                                byteSeq);
        }
        /**
         * Writes samples to DDS. This method never returns.
         */
        public void writeSamples() {
            DDS.InstanceHandle_t instance_handle = DDS.InstanceHandle_t.HANDLE_NIL;
            /* For a data type that has a key, if the same instance is going to be
             * written multiple times, initialize the key here
             * and register the keyed instance prior to writing
             */
            /* instance_handle = writer.register_instance(instance);
             */
            Console.WriteLine("Sending data...");
            int consecutiveErrors = 0;
            for (int count = 0; ; ++count) {
                _theInstance.set_int("sampleId",
                        DDS.DynamicData.MEMBER_ID_UNSPECIFIED,
                        count);
                try {
                    _theDataWriter.write(_theInstance, ref instance_handle);
                } catch (DDS.Retcode_Error e) {
                    Console.Error.WriteLine("! Write error " +
                                e.GetType().ToString() + ": " + e.Message);
                    if (++consecutiveErrors > MAX_CONSECUTIVE_WRITE_ERROR) {
                        Console.WriteLine("! Reached maximum number of failure, stopping writer...");
                        return;
                    }
                }
                /* Always clear the error count in case of successful write */
                consecutiveErrors = 0;
                if (_theVerbose > 0 && (count % 10000) == 0) {
                    Console.WriteLine("Sent " + count + " samples...");
                }
                if (_theSampleCount != 0 && (count >= _theSampleCount)) {
                    Console.WriteLine("Sent " + count + " samples.");
                    break;
                }
            }
        }
    }
}
