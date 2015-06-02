/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#ifndef __HELLO_PUBLISHER_H_INCLUDED__
#define __HELLO_PUBLISHER_H_INCLUDED__


#include <ndds/ndds_c.h>

#include "News.h"


/* Builds a new NewsPublisher object and initialize the inner DDS 
 * entities. Then publish the data.
 *
 * Parameters:
 *     participant  the DomainParticipant
 *     topic        the Topic 
 *     verbose      the output verbosity
 *     runSeconds   the number of seconds to publish
 */
DDS_Boolean publish(DDS_DomainParticipant* participant,
                    DDS_Topic* topic,
                    DDS_Long verbose,
                    DDS_Long run_seconds);


#endif            /* !defined(__HELLO_PUBLISHER_H_INCLUDED__) */
