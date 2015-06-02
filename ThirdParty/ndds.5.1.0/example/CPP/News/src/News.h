/****************************************************************************/
/*         (c) Copyright, Real-Time Innovations, All rights reserved.       */
/*                                                                          */
/*         Permission to modify and use for internal purposes granted.      */
/* This software is provided "as is", without warranty, express or implied. */
/*                                                                          */
/****************************************************************************/

#ifndef __HELLO_H_INCLUDED__
#define __HELLO_H_INCLUDED__


/* Both the publisher(s) and the subscriber(s) will print out their
 * status after this many milliseconds.
 */
#define STATUS_PERIOD_MILLIS    (2 * 1000)


/****************************************************************************/
/* Unify some common functions and types between Unix and Windows           */
/****************************************************************************/

#ifdef RTI_WIN32
#define RTI_SNPRINTF        _snprintf
#define RTI_STRCASECMP      _stricmp
#define RTI_STRNCASECMP     _strnicmp
#define RTI_STRTOULL        _strtoui64
#define RTI_STRTOUL         strtoul
#define RTI_STRNCMP         strncmp
#else
#define RTI_SNPRINTF        snprintf
#define RTI_STRCASECMP      strcasecmp
#define RTI_STRNCASECMP     strncasecmp
#define RTI_STRTOULL        strtoull
#define RTI_STRTOUL         strtoul
#define RTI_STRNCMP         strncmp
#endif


/****************************************************************************/
/* Article Class                                                            */
/****************************************************************************/

class Article;

std::ostream& operator <<(std::ostream& stream, const Article& article);

/* A helper class that formats the news outlet name together with the
 * article text for output to the terminal.
 */
class Article {
private:
    std::string _stringified;

public:
    Article(
        const std::string& newsOutletName, const std::string& articleText);
    Article(const Article& src);

    friend std::ostream& operator <<(std::ostream&, const Article&);
};


#endif            /* !defined(__HELLO_H_INCLUDED__) */
