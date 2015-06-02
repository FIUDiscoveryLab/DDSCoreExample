/*****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.        */
/*                                                                           */
/*         Permission to modify and use for internal purposes granted.       */
/* This software is provided "as is", without warranty, express or implied.  */
/*                                                                           */
/*****************************************************************************/

#ifndef __HELLO_SUBSCRIBER_H_INCLUDED__
#define __HELLO_SUBSCRIBER_H_INCLUDED__


#include <ndds/ndds_c.h>


DDS_Boolean read_articles(
        DDS_DomainParticipant* participant,
        DDS_Topic* topic,
        DDS_Long verbose,
        DDS_Long run_seconds,
        const char* content_filter);


#endif            /* !defined(__HELLO_SUBSCRIBER_H_INCLUDED__) */
