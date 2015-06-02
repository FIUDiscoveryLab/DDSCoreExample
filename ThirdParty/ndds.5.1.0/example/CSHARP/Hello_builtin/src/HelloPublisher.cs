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

        private DDS.StringDataWriter _theDataWriter;
        private String               _thePayloadString;
        private int                  _theVerbose;
        private int                  _theSampleCount;

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

            _theDataWriter = (DDS.StringDataWriter)participant.create_datawriter(
                            topic,
                            DDS.Publisher.DATAWRITER_QOS_DEFAULT,
                            null, /* Listener */
                            DDS.StatusMask.STATUS_MASK_NONE);
            if (_theDataWriter == null) {
                Console.Error.WriteLine("! Unable to create DDS data writer");
                return;
            }
            char[] sampleArray = new char[dataSize - 10];
            for (int i = 0; i < dataSize - 10; ++i) {
                sampleArray[i] = (char)('A' + (i % 26));
            }
            _thePayloadString = new String(sampleArray);
        }

        /**
         * Writes samples to DDS. This method never returns.
         */
        public void writeSamples() {
            StringBuilder instanceBuffer = new StringBuilder("          ");
            instanceBuffer.Append(_thePayloadString);

            Console.WriteLine("Sending data...");
            int consecutiveErrors = 0;
            for (int count = 0; ; ++count) {
                /* Fill up the first 9 character of the payload string by
                 * writing the count number (converted to string) in the
                 * StringBuilder.
                 *
                 * Converting an integer to a string is relatively expensive
                 * and could impact the throughput. But since this is just an
                 * example, let's keep it simple.
                 */
                String countString = count.ToString();
                for (int l = 0; l < countString.Length; ++l) {
                    instanceBuffer[l] = countString[l];
                }
                try {
                    String bufferToWrite = instanceBuffer.ToString();
                    _theDataWriter.write(bufferToWrite, ref DDS.InstanceHandle_t.HANDLE_NIL);
                }
                catch (DDS.Retcode_Error e) {
                    Console.Error.WriteLine("! Write error "
                                    + e.GetType().ToString() + ": " + e.Message);
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
