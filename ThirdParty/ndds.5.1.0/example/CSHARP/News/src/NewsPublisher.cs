/* ***************************************************************************
 *         (c) Copyright, Real-Time Innovations, All rights reserved.       
 *                                                                          
 *         Permission to modify and use for internal purposes granted.      
 * This software is provided "as is", without warranty, express or implied. 
 *                                                                          
 * ***************************************************************************
 */
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

using DDS;


namespace News {
    /* Manage the data publication for the News example. Several news outlets
     * publish articles periodically but at different rates.
     */
    internal class NewsPublisher {
        // -------------------------------------------------------------------
        // Fields
        // -------------------------------------------------------------------
        
        /* Articles from these news outlets will be published periodically at
         * different rates.
         */
        private NewsOutlet[] _newsOutlets;
    
        private KeyedStringDataWriter _writer;
        private int                   _runSeconds;
    
    
    
        // -------------------------------------------------------------------
        // Public Methods
        // -------------------------------------------------------------------
    
        /* Builds a new NewsPublisher object and initialize the inner DDS 
         * entities.
         * 
         * This method only creates the entities; it does not actually publish
         * the data.
         * 
         * To publish the data, use the method run().
         * 
         * Parameters:
         *     participant  the DomainParticipant
         *     topic        the Topic 
         *     verbose      the output verbosity
         *     runSeconds   the number of seconds to publish
         */
        public NewsPublisher(
                DomainParticipant participant,
                Topic topic,
                int verbose,
                int runSeconds) {
            _runSeconds = runSeconds;
            
            // --- Create DataWriter --- // 
            /* If you want to customize the writer QoS, use
             * Publisher.get_default_datawriter_qos() to 
             * initialize a local copy of the default QoS, modify them, then
             * use them in the creation call below instead of 
             * DATAWRITER_QOS_DEFAULT.
             */
            if (verbose > 0) {
                Console.WriteLine("Creating the DataWriter...");
            }
            _writer = (KeyedStringDataWriter) participant.create_datawriter(
                    topic,
                    Publisher.DATAWRITER_QOS_DEFAULT,
                    null,                           // no listener
                    StatusMask.STATUS_MASK_NONE);   // no listener callbacks
            if (_writer == null) {
                throw new ApplicationException("Unable to create DataWriter");
            }

            // --- Create news outlets --- //
            _newsOutlets = new NewsOutlet[] {
                new NewsOutlet("Reuters", _writer),
                new NewsOutlet("AP", _writer),
                new NewsOutlet("CNN", _writer),
                new NewsOutlet("Bloomberg", _writer),
                new NewsOutlet("NY Times", _writer),
                new NewsOutlet("Economist", _writer)
            };

            // --- Register news outlets --- //
            for (int i = 0; i < _newsOutlets.Length; ++i) {
                _newsOutlets[i].RegisterNewsOutlet();
            }
        }
    
    
        // Publish articles.
        public void Publish() {
            const int MILLIS_PER_SEC = 1000;
            const int PUBLISH_PERIOD_MILLIS = News.STATUS_PERIOD_MILLIS / 10;
    
            List<News.Article> articlesInLastStatusPeriod =
                new List<News.Article>();
            for (int elapsedMillis = 0;
                     elapsedMillis < _runSeconds * MILLIS_PER_SEC;
                     elapsedMillis += PUBLISH_PERIOD_MILLIS) {
                // --- Publish articles --- //
                for (int i = 0; i < _newsOutlets.Length; ++i) {
                    /* Publish the articles at different rates: the first
                     * outlet's articles every round, the second outlet's
                     * every other, the third's every third, and so on.
                     */
                    if (elapsedMillis / PUBLISH_PERIOD_MILLIS % (i + 1) == 0){
                        NewsOutlet newsOutlet = _newsOutlets[i];
                        News.Article article =
                            newsOutlet.PublishNextArticle();
                        articlesInLastStatusPeriod.Add(article);
                    }
                }
    
                // --- Print periodic status --- //
                if (elapsedMillis > 0 &&
                        elapsedMillis % News.STATUS_PERIOD_MILLIS == 0) {
                    ReportArticlesPublished(articlesInLastStatusPeriod);
                    articlesInLastStatusPeriod.Clear();
                }
    
                // --- Sleep --- //
                // ...until it's time to publish again.
                try {
                    Thread.Sleep(PUBLISH_PERIOD_MILLIS);
                } catch (System.Exception ex) {
                    Console.Error.WriteLine(ex.StackTrace);
                    break;
                }
            }
    
            // Print final status:
            ReportArticlesPublished(articlesInLastStatusPeriod);
        }
    
    
    
        // -------------------------------------------------------------------
        // Private Methods
        // -------------------------------------------------------------------
    
        private void ReportArticlesPublished(
                List<News.Article> articlesPublished) {
            if (articlesPublished.Count > 0) {
                Console.WriteLine(
                        "Articles published in last period as of " +
                        DateTime.Now.ToLongTimeString() + ':');
                for (IEnumerator<News.Article> it =
                             articlesPublished.GetEnumerator();
                         it.MoveNext(); ) {
                    Console.WriteLine("    " + it.Current);
                }
            }
        }
    
    }


    // =======================================================================

    internal class NewsOutlet {
        // --- Private fields: -----------------------------------------------
        // Maximum consecutive write error after stopping the write process.
        private const int MAX_CONSECUTIVE_WRITE_ERROR = 5;

        // The name of a news outlet.
        private String _name;

        /* The handle that helps the middleware locate the instance to which
         * a sample will be published.
         * 
         * @see #registerNewsOutlet()
         */
        private InstanceHandle_t _handle = InstanceHandle_t.HANDLE_NIL;

        // The number of articles this outlet has published.
        private int _articleCount = 0;

        // The writer wrapped by this NewsOutlet.
        private KeyedStringDataWriter _writer;


        // --- Public methods: -----------------------------------------------
        public NewsOutlet(String theName, KeyedStringDataWriter writer) {
            _name = theName;
            _writer = writer;
        }

        public News.Article PublishNextArticle() {
            // --- Build article text --- //
            StringBuilder articleTextBuffer = new StringBuilder();
            articleTextBuffer.Append("lorem ipsum ");
            articleTextBuffer.Append(++_articleCount);
            String articleText = articleTextBuffer.ToString();

            // --- Try to publish article --- //
            DDS.Exception lastWriteError = null;
            for (int i = 0; i < MAX_CONSECUTIVE_WRITE_ERROR; ++i) {
                try {
                    _writer.write(_name, articleText, ref _handle);
                    return new News.Article(_name, articleText);
                } catch (DDS.Exception ex) {
                    lastWriteError = ex;
                    Console.Error.WriteLine("! Write error: " + ex);
                }
            }

            // --- Report publication error --- //
            Console.WriteLine(
                "! Reached maximum number of failures: stopping publishing...");
            throw lastWriteError;
        }

        public void RegisterNewsOutlet() {
            /* When working with keyed data types, you can "register" an
             * instance before writing it, which will give you back an
             * "instance handle." By providing this handle back to the writer
             * when you write a sample, you help the middleware locate its
             * internal data structures associated with that instance,
             * enabling the writer to work more efficiently.
             * 
             * Pre-registering an instance is optional; you can always pass a
             * "nil" handle to the writer when writing, and it will
             * recalculate the instance on the fly. Consider pre-registering
             * your instance(s) if throughput and/or writer CPU usage are
             * significant concerns.
             */
            _handle = _writer.register_instance(_name);
        }
    }

}
