// ***************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.
//
//         Permission to modify and use for internal purposes granted.
// This software is provided "as is", without warranty, express or implied.
//
// ***************************************************************************

package com.rti.dds.example.news;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.rti.dds.domain.DomainParticipant;
import com.rti.dds.infrastructure.InstanceHandle_t;
import com.rti.dds.infrastructure.RETCODE_ERROR;
import com.rti.dds.infrastructure.StatusKind;
import com.rti.dds.publication.Publisher;
import com.rti.dds.topic.Topic;
import com.rti.dds.type.builtin.KeyedStringDataWriter;


//****************************************************************************

/**
 * Manage the data publication for the News example. Several news outlets
 * publish articles periodically but at different rates.
 */
/*package*/ class NewsPublisher {
    // -----------------------------------------------------------------------
    // Fields
    // -----------------------------------------------------------------------
    
    /**
     * Articles from these news outlets will be published periodically at
     * different rates.
     */
    private final NewsOutlet[] _newsOutlets = new NewsOutlet[] {
            new NewsOutlet("Reuters"),
            new NewsOutlet("AP"),
            new NewsOutlet("CNN"),
            new NewsOutlet("Bloomberg"),
            new NewsOutlet("NY Times"),
            new NewsOutlet("Economist")
        };

    private KeyedStringDataWriter _writer;
    private int                   _runSeconds;



    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    /**
     * Builds a new NewsPublisher object and initialize the inner DDS 
     * entities.
     * 
     * This method only creates the entities; it does not actually publish
     * the data.
     * 
     * To publish the data, use the method run().
     *  
     * @param participant  the DomainParticipant
     * @param topic        the Topic 
     * @param verbose      the output verbosity
     * @param runSeconds   the number of seconds to publish
     */
    public NewsPublisher(
            DomainParticipant participant,
            Topic topic,
            int verbose,
            int runSeconds) {
        _runSeconds = (runSeconds > 0) ? runSeconds : Integer.MAX_VALUE;
        
        // --- Create DataWriter --- // 
        /* If you want to customize the writer QoS, use
         * Publisher.get_default_datawriter_qos() to 
         * initialize a local copy of the default QoS, modify them, then
         * use them in the creation call below instead of 
         * DATAWRITER_QOS_DEFAULT.
         */
        if (verbose > 0) {
            System.out.println("Creating the DataWriter...");
        }
        _writer = (KeyedStringDataWriter) participant.create_datawriter(
                topic,
                Publisher.DATAWRITER_QOS_DEFAULT,
                null,                           // no listener
                StatusKind.STATUS_MASK_NONE);   // no listener callbacks
        if (_writer == null) {
            throw new IllegalStateException("Unable to create DataWriter");
        }

        // --- Register news outlets --- //
        for (int i = 0; i < _newsOutlets.length; ++i) {
            _newsOutlets[i].registerNewsOutlet();
        }
    }


    /**
     * Publish articles.
     */
    public void publish() {
        final int MILLIS_PER_SEC = 1000;
        final int PUBLISH_PERIOD_MILLIS = News.STATUS_PERIOD_MILLIS / 10;

        List articlesInLastStatusPeriod = new ArrayList();
        for (int elapsedMillis = 0;
                 elapsedMillis < _runSeconds * MILLIS_PER_SEC;
                 elapsedMillis += PUBLISH_PERIOD_MILLIS) {
            // --- Publish articles --- //
            for (int i = 0; i < _newsOutlets.length; ++i) {
                /* Publish the articles at different rates: the first
                 * outlet's articles every round, the second outlet's every
                 * other, the third's every third, and so on.
                 */
                if (elapsedMillis / PUBLISH_PERIOD_MILLIS % (i + 1) == 0) {
                    NewsOutlet newsOutlet = _newsOutlets[i];
                    News.Article article = newsOutlet.publishNextArticle();
                    articlesInLastStatusPeriod.add(article);
                }
            }

            // --- Print periodic status --- //
            if (elapsedMillis > 0 &&
                    elapsedMillis % News.STATUS_PERIOD_MILLIS == 0) {
                reportArticlesPublished(articlesInLastStatusPeriod);
                articlesInLastStatusPeriod.clear();
            }

            // --- Sleep --- //
            // ...until it's time to publish again.
            try {
                Thread.sleep(PUBLISH_PERIOD_MILLIS);
            } catch (InterruptedException ix) {
                break;
            }
        }

        // Print final status:
        reportArticlesPublished(articlesInLastStatusPeriod);
    }



    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------

    private void reportArticlesPublished(List articlesPublished) {
        if (!articlesPublished.isEmpty()) {
            System.out.println(
                    "Articles published in last period as of " +
                    DateFormat.getTimeInstance().format(new Date()) +
                    ':');
            for (Iterator it = articlesPublished.iterator(); it.hasNext();) {
                System.out.println("    " + it.next());
            }
        }
    }



    // -----------------------------------------------------------------------
    // Types
    // -----------------------------------------------------------------------

    // =======================================================================

    private class NewsOutlet {
        // --- Private fields: -----------------------------------------------
        /**
         * Maximum consecutive write error after stopping the write process.
         */
        private static final int MAX_CONSECUTIVE_WRITE_ERROR = 5;

        /**
         * The name of a news outlet.
         */
        private final String _name;

        /**
         * The handle that helps the middleware locate the instance to which
         * a sample will be published.
         * 
         * @see #registerNewsOutlet()
         */
        private InstanceHandle_t _handle = InstanceHandle_t.HANDLE_NIL;

        /**
         * The number of articles this outlet has published.
         */
        private int _articleCount = 0;


        // --- Public methods: -----------------------------------------------
        public NewsOutlet(String theName) {
            _name = theName;
        }

        public News.Article publishNextArticle() {
            // --- Build article text --- //
            StringBuffer articleTextBuffer = new StringBuffer();
            articleTextBuffer.append("lorem ipsum ");
            articleTextBuffer.append(++_articleCount);
            String articleText = articleTextBuffer.toString();

            // --- Try to publish article --- //
            RETCODE_ERROR lastWriteError = null;
            for (int i = 0; i < MAX_CONSECUTIVE_WRITE_ERROR; ++i) {
                try {
                    _writer.write(_name, articleText, _handle);
                    return new News.Article(_name, articleText);
                } catch (RETCODE_ERROR ex) {
                    lastWriteError = ex;
                    System.err.println("! Write error: " + ex);
                }
            }

            // --- Report publication error --- //
            System.out.println(
                "! Reached maximum number of failures: stopping publishing...");
            throw lastWriteError;
        }

        public void registerNewsOutlet() {
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
