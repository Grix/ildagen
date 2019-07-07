// -------------------------------------------------------------------------------------------------
//  File idn-hello.h
//
//  07/2013 Dirk Apitz, created
//  06/2015 Dirk Apitz, Scan response: protocol version moved, name len changed
//  12/2015 Dirk Apitz, Service map
//  05/2016 Dirk Apitz, Generic data types
// -------------------------------------------------------------------------------------------------


#ifndef IDN_HELLO_H
#define IDN_HELLO_H


// Standard libraries
#include <stdint.h>


// -------------------------------------------------------------------------------------------------
//  Defines
// -------------------------------------------------------------------------------------------------

// Packet commands
#define IDNCMD_VOID                         0x00
#define IDNCMD_PING_REQUEST                 0x08
#define IDNCMD_PING_RESPONSE                0x09

#define IDNCMD_SCAN_REQUEST                 0x10
#define IDNCMD_SCAN_RESPONSE                0x11
#define IDNCMD_SERVICEMAP_REQUEST           0x12
#define IDNCMD_SERVICEMAP_RESPONSE          0x13

#define IDNCMD_SERVICE_PARAMETERS_REQUEST   0x20
#define IDNCMD_SERVICE_PARAMETERS_RESPONSE  0x21
#define IDNCMD_UNIT_PARAMETERS_REQUEST      0x22
#define IDNCMD_UNIT_PARAMETERS_RESPONSE     0x23
#define IDNCMD_LINK_PARAMETERS_REQUEST      0x28
#define IDNCMD_LINK_PARAMETERS_RESPONSE     0x29

#define IDNCMD_MESSAGE                      0x40


// -------------------------------------------------------------------------------------------------
//  Typedefs
// -------------------------------------------------------------------------------------------------

typedef struct
{
    uint8_t command;                            // The command code (IDNCMD_*)
    uint8_t flags;
    uint16_t sequence;                          // Sequence counter, must count up
    
} IDNHDR_PACKET;


typedef struct _IDNHDR_SCAN_RESPONSE
{
    uint8_t structSize;                         // Size of this struct.
    uint8_t protocolVersion;                    // 4 bit major (msb), 4 bit minor (lsb)
    uint16_t reserved;
    uint8_t unitID[16];
    uint8_t name[20];                           // Not terminated, shorter names padded with '\0'

} IDNHDR_SCAN_RESPONSE;


typedef struct _IDNHDR_SERVICEMAP_RESPONSE
{
    uint8_t structSize;                         // Size of this struct.
    uint8_t entrySize;
    uint16_t entryCount;

} IDNHDR_SERVICEMAP_RESPONSE;


typedef struct _IDNHDR_SERVICEMAP_ENTRY
{
    uint8_t serviceID;
    uint8_t serviceType;
    uint8_t flags;
    uint8_t unitNumber;
    uint8_t name[20];                           // Not terminated, shorter names padded with '\0'

} IDNHDR_SERVICEMAP_ENTRY;



// Icon
// ??? Properties: Wavelength



#endif

