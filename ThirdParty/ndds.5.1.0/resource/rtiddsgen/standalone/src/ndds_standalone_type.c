/* $Id: ndds_standalone_type.c,v 1.2 2013/09/12 14:22:29 fernando Exp $
 (c) Copyright, Real-Time Innovations, $Date: 2013/09/12 14:22:29 $. 
 All rights reserved.
 No duplications, whole or partial, manual or electronic, may be made
 without express written permission.  Any such copies, or
 revisions thereof, must display this notice unaltered.
 This code contains trade secrets of Real-Time Innovations, Inc.
 
modification history
--------------------
10h,15aug06,kaj 64 bit: Convert APIs from long to DDS_Long
10e,17dec05,fcs Replaced T_initialize_simple and T_finalize_simple
                with T_initialize and T_finalize
10e,11aug05,fcs Removed #include <stdarg.h>
10e,09aug05,fcs Created 

Description
-----------

C source code file necessary to compile and use the nddsgen generated types
without linking with the NDDS libraries.
*/

#include "ndds_standalone_type.h"

/* =============================================================================
 *  LOG
 * ===========================================================================*/
 
/*
 */
 
int RTILog_vprintContextAndMsg(const char* context,
                               const char* errMsg, va_list ap)
{
    int n=0, len;
    char tempStr[RTI_LOG_MSG_SIZE_MAX];
    char tempBuf[RTI_LOG_MSG_SIZE_MAX];

    tempStr[0] = 0;
    tempBuf[0] = 0;

    /* prepend message by context string, followed by a colon ':' */
    if (context != NULL) {
        strcat(tempStr, context);
        strcat(tempStr, ":");
    }

    len = strlen(tempStr);
    tempStr[RTI_LOG_MSG_SIZE_MAX-1] = 0;

    /* add the actual log message in the desired format */
    n = vsnprintf(tempStr+len, RTI_LOG_MSG_SIZE_MAX-len-1, errMsg,ap);

    /* return length of (non-truncated) message */
    return (n+len);
}

/*
 */
 
int RTILog_printContextAndMsg(const char *context,
                              const void *errMsg, ...)
{
    int len;
    va_list ap;

    va_start(ap, errMsg);
    len = RTILog_vprintContextAndMsg(context,(const char *)errMsg, ap);
    va_end(ap);

    return len;
}

/* =============================================================================
 *  OSAPI
 * ===========================================================================*/

RTIBool
RTIOsapiHeap_reallocateString(char **stringStoragePointer, int stringSize)
{ 
   char* result = (char*)realloc(*stringStoragePointer, stringSize+1);    
   
   if (result != NULL) {
        result[stringSize] = '\0';
        *stringStoragePointer = result;
   }    
   return result != NULL; 
}
  
/* =============================================================================
 *  CDR
 * ===========================================================================*/

unsigned int RTICdrType_getWstringLength(const RTICdrWchar * str)
{      
    unsigned int i = 0; 
    if (str == NULL) return -1;
    while ((*str++) != '\0') i++;
    return i;
}

/*
 */
RTIBool RTICdrType_initStringArray(
    void *value, RTICdrUnsignedLong length,
    RTICdrUnsignedLong maximumStringLength,
    RTICdrPrimitiveType type)
{
    unsigned int i;
    unsigned int size;    
    RTICdrChar ** valueChar=NULL;    
    RTICdrWchar ** valueWchar=NULL;
    
    if ((value == NULL) || (length<0) || (maximumStringLength<1)) {
        return RTI_FALSE;
    }
     
    size=RTICdrType_getPrimitiveTypeSize(type);
    
    if (type==RTI_CDR_WCHAR_TYPE){    
         valueWchar=(RTICdrWchar **)value;
    }else{
         valueChar=(RTICdrChar **)value;
    }
         
    RTIOsapiMemory_zero(value,size*length);
    
    for (i=0;i<length;i++){
        if (type==RTI_CDR_WCHAR_TYPE){
            RTIOsapiHeap_allocateArray(&valueWchar[i],maximumStringLength,RTICdrWchar);            
            if (!RTICdrType_initWstring(valueWchar[i],maximumStringLength)){
                RTICdrType_finalizeStringArray(value,length,type);            
                return RTI_FALSE;
            }
        }else{
            RTIOsapiHeap_allocateString(&valueChar[i],maximumStringLength-1);
            if (!RTICdrType_initString(valueChar[i],maximumStringLength)){
                RTICdrType_finalizeStringArray(value,length,type);
                return RTI_FALSE;
            }
        }
    }
    
    return RTI_TRUE;
}

/*
 */
 
RTIBool RTICdrType_finalizeStringArray(void *value, RTICdrUnsignedLong length,RTICdrPrimitiveType type)
{
    unsigned int i;
    RTICdrChar  ** valueChar=NULL;    
    RTICdrWchar ** valueWchar=NULL;
    
    if ((value == NULL) || (length<0))
        return RTI_FALSE;
     
    if (type==RTI_CDR_WCHAR_TYPE){    
         valueWchar=(RTICdrWchar **)value;
    }else{
         valueChar=(RTICdrChar **)value;
    }
     
    for (i=0;i<length;i++){
        if (type==RTI_CDR_WCHAR_TYPE){
            if (valueWchar[i]!=NULL) RTIOsapiHeap_freeArray(valueWchar[i]);
            valueWchar[i]=NULL;
        }else{
            if (valueChar[i]!=NULL) RTIOsapiHeap_freeString(valueChar[i]);
            valueChar[i]=NULL;
        }
    }      
    
    return RTI_TRUE;
}

/*
 */
 
RTIBool RTICdrType_copyStringArray(void *out, const void* in, RTICdrUnsignedLong length,
    RTICdrUnsignedLong maximumStringLength,RTICdrPrimitiveType type)
{
    unsigned int i;
    
    if ((out == NULL) || (in == NULL) || (length<0) || (maximumStringLength<1))
        return RTI_FALSE;
          
    for (i=0;i<length;i++){
        if (type==RTI_CDR_WCHAR_TYPE){
            if (!RTICdrType_copyWstring(((RTICdrWchar **)out)[i],((RTICdrWchar **)in)[i],maximumStringLength)){
                return RTI_FALSE;    
            }
        }else{
            if (!RTICdrType_copyString(((RTICdrChar **)out)[i],((RTICdrChar **)in)[i],maximumStringLength)){
                return RTI_FALSE;             
            }
        }
    }     
    
    return RTI_TRUE;      
}

/* =============================================================================
 *  DDS
 * ===========================================================================*/
 
/*
 */

const struct DDS_TypeAllocationParams_t DDS_TYPE_ALLOCATION_PARAMS_DEFAULT =
{
    DDS_BOOLEAN_TRUE,
    DDS_BOOLEAN_FALSE,
    DDS_BOOLEAN_TRUE
};

/*
 */

const struct DDS_TypeDeallocationParams_t DDS_TYPE_DEALLOCATION_PARAMS_DEFAULT =
{
    DDS_BOOLEAN_TRUE,
    DDS_BOOLEAN_TRUE
};

/*
 */
 
DDS_UnsignedLong DDS_Wstring_length(const DDS_Wchar* string) {
    const char *const METHOD_NAME = "DDS_Wstring_length";
    const DDS_Wchar* i = NULL;
    
    if (string == NULL) {
        DDSLog_exception(METHOD_NAME, &DDS_LOG_BAD_PARAMETER_s, "string");
        return 0;
    }
    
    for (i = string; *i != 0; ++i);
    return (i - string);
}

/*
 */
 
char* DDS_String_alloc(DDS_UnsignedLong length) {
    char* string = NULL;
    RTIOsapiHeap_allocateString(&string, length);    
    return string;           
}

/*
 */
 
DDS_Wchar* DDS_Wstring_alloc(DDS_UnsignedLong length) {
    DDS_Wchar* string = NULL;
    RTIOsapiHeap_allocateArray(&string, length + 1, DDS_Wchar);
    return string;           
}

/*
 */
 
char* 
DDS_String_replace(char** string_ptr, const char* new_value) {
    
    const char *const METHOD_NAME = "DDS_String_replace";
    char* result = NULL;
    
    /* --- check parameters --- */
    if (string_ptr == NULL) {
       DDSLog_exception(METHOD_NAME, &DDS_LOG_BAD_PARAMETER_s, "string_ptr");
       goto done; 
    }    
       
    /* NULL string */           
    if (new_value == NULL) {
       DDS_String_free(*string_ptr);      
       *string_ptr = result = NULL;
       
    /* Replace old value */    
    } else {
           
       if (RTIOsapiHeap_reallocateString(string_ptr, strlen(new_value))) {              
          strcpy(*string_ptr, new_value);    /* copy */  
          result = *string_ptr;                    
       } else {
          DDSLog_exception(METHOD_NAME, &DDS_LOG_OUT_OF_RESOURCES_s,
                          "reallocating string");           
       }       
    }
        
done:    
    return result;              
}

/*
 */
 
void DDS_StringSeq_initialize_string(char** string) {
    if (string != NULL) {
        *string = NULL;
    }
}

/*
 */
 
void DDS_StringSeq_finalize_string(char** string) {
    DDS_String_free(*string);
    *string = NULL;
}

/*
 */
 
char** DDS_StringSeq_copy_string(char** self, const char** from) {
    DDS_String_replace(self, *from); 
    return self;
}

/*
 */
 
DDS_Wchar* DDS_Wstring_replace(DDS_Wchar** string_ptr,
                               const DDS_Wchar* new_value) {
    const char *const METHOD_NAME = "DDS_Wstring_replace";
    DDS_Wchar* result = NULL;
    DDS_UnsignedLong length = 0;
        
    /* --- check parameters --- */
    if (string_ptr == NULL) {
        DDSLog_exception(METHOD_NAME, &DDS_LOG_BAD_PARAMETER_s, "string_ptr");
        goto done; 
    }

    /* NULL string */           
    if (new_value == NULL) {
        DDS_Wstring_free(*string_ptr);      
        *string_ptr = result = NULL;

    /* Replace old value */    
    } else {
       length=(DDS_Wstring_length(new_value)+1)*sizeof(DDS_Wchar);
       if ((*string_ptr=(DDS_Wchar *)realloc(*string_ptr,length))) {              
          memcpy(*string_ptr,new_value,length);             
          result = *string_ptr;                    
       } else {
          DDSLog_exception(METHOD_NAME, &DDS_LOG_OUT_OF_RESOURCES_s,
                          "reallocating string");           
       }              
    }
        
done:    
    return result;              
}

/*
 */
 
void DDS_WstringSeq_initialize_string(RTICdrWchar** wstring) {
    if (wstring != NULL) {
        *wstring = NULL;
    }
}

/*
 */
 
void DDS_WstringSeq_finalize_string(RTICdrWchar** wstring) {
    DDS_Wstring_free(*wstring);      
}

/*
 */
 
DDS_Wchar** DDS_WstringSeq_copy_string(DDS_Wchar** dst,
                                       const DDS_Wchar** src) {
    DDS_Wstring_replace(dst, *src); 
    return dst;
}

/* =============================================================================
 *  Primitives Sequences
 * ===========================================================================*/

#define T DDS_Char
#define TSeq DDS_CharSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Wchar
#define TSeq DDS_WcharSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Octet
#define TSeq DDS_OctetSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Short
#define TSeq DDS_ShortSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_UnsignedShort
#define TSeq DDS_UnsignedShortSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Long
#define TSeq DDS_LongSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_UnsignedLong
#define TSeq DDS_UnsignedLongSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_LongLong
#define TSeq DDS_LongLongSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_UnsignedLongLong
#define TSeq DDS_UnsignedLongLongSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Float
#define TSeq DDS_FloatSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Double
#define TSeq DDS_DoubleSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_LongDouble
#define TSeq DDS_LongDoubleSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define T DDS_Boolean
#define TSeq DDS_BooleanSeq
#include "dds_c_sequence_TSeq.gen"
#undef TSeq
#undef T

#define TSeq DDS_StringSeq
#define T DDS_Char*
#define T_initialize    DDS_StringSeq_initialize_string
#define T_finalize      DDS_StringSeq_finalize_string  
#define T_copy          DDS_StringSeq_copy_string
#include "dds_c_sequence_TSeq.gen"
#undef T_copy
#undef T_finalize
#undef T_initialize
#undef T
#undef TSeq

#define TSeq DDS_WstringSeq
#define T DDS_Wchar*
#define T_initialize DDS_WstringSeq_initialize_string
#define T_finalize   DDS_WstringSeq_finalize_string
#define T_copy       DDS_WstringSeq_copy_string
#include "dds_c_sequence_TSeq.gen"
#undef T_copy
#undef T_initialize
#undef T_finalize
#undef T
#undef TSeq

