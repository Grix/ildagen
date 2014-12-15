//argument0 is a value from FMODGetLastError()

//show_debug_message(FMODErrorStr(FMODGetLastError()))
var FMOD_OK,
    FMOD_ERR_ALREADYLOCKED,         /* Tried to call lock a second time before unlock was called. */
    FMOD_ERR_BADCOMMAND,            /* Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound). */
    FMOD_ERR_CDDA_DRIVERS,          /* Neither NTSCSI nor ASPI could be initialised. */
    FMOD_ERR_CDDA_INIT,             /* An error occurred while initialising the CDDA subsystem. */
    FMOD_ERR_CDDA_INVALID_DEVICE,   /* Couldn't find the specified device. */
    FMOD_ERR_CDDA_NOAUDIO,          /* No audio tracks on the specified disc. */
    FMOD_ERR_CDDA_NODEVICES,        /* No CD/DVD devices were found. */ 
    FMOD_ERR_CDDA_NODISC,           /* No disc present in the specified drive. */
    FMOD_ERR_CDDA_READ,             /* A CDDA read error occurred. */
    FMOD_ERR_CHANNEL_ALLOC,         /* Error trying to allocate a channel. */
    FMOD_ERR_CHANNEL_STOLEN,        /* The specified channel has been reused to play another sound. */
    FMOD_ERR_COM,                   /* A Win32 COM related error occured. COM failed to initialize or a QueryInterface failed meaning a Windows codec or driver was not installed properly. */
    FMOD_ERR_DMA,                   /* DMA Failure.  See debug output for more information. */
    FMOD_ERR_DSP_CONNECTION,        /* DSP connection error.  Connection possibly caused a cyclic dependancy. */
    FMOD_ERR_DSP_FORMAT,            /* DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format. */
    FMOD_ERR_DSP_NOTFOUND,          /* DSP connection error.  Couldn't find the DSP unit specified. */
    FMOD_ERR_DSP_RUNNING,           /* DSP error.  Cannot perform this operation while the network is in the middle of running.  This will most likely happen if a connection or disconnection is attempted in a DSP callback. */
    FMOD_ERR_DSP_TOOMANYCONNECTIONS,/* DSP connection error.  The unit being connected to or disconnected should only have 1 input or output. */
    FMOD_ERR_FILE_BAD,              /* Error loading file. */
    FMOD_ERR_FILE_COULDNOTSEEK,     /* Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format. */
    FMOD_ERR_FILE_DISKEJECTED,      /* Media was ejected while reading. */
    FMOD_ERR_FILE_EOF,              /* End of file unexpectedly reached while trying to read essential data (truncated data?). */
    FMOD_ERR_FILE_NOTFOUND,         /* File not found. */
    FMOD_ERR_FILE_UNWANTED,         /* Unwanted file access occured. */
    FMOD_ERR_FORMAT,                /* Unsupported file or audio format. */
    FMOD_ERR_HTTP,                  /* A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere. */
    FMOD_ERR_HTTP_ACCESS,           /* The specified resource requires authentication or is forbidden. */
    FMOD_ERR_HTTP_PROXY_AUTH,       /* Proxy authentication is required to access the specified resource. */
    FMOD_ERR_HTTP_SERVER_ERROR,     /* A HTTP server error occurred. */
    FMOD_ERR_HTTP_TIMEOUT,          /* The HTTP request timed out. */
    FMOD_ERR_INITIALIZATION,        /* FMOD was not initialized correctly to support this function. */
    FMOD_ERR_INITIALIZED,           /* Cannot call this command after System::init. */
    FMOD_ERR_INTERNAL,              /* An error occured that wasn't supposed to.  Contact support. */
    FMOD_ERR_INVALID_ADDRESS,       /* On Xbox 360, this memory address passed to FMOD must be physical, (ie allocated with XPhysicalAlloc.) */
    FMOD_ERR_INVALID_FLOAT,         /* Value passed in was a NaN, Inf or denormalized float. */
    FMOD_ERR_INVALID_HANDLE,        /* An invalid object handle was used. */
    FMOD_ERR_INVALID_PARAM,         /* An invalid parameter was passed to this function. */
    FMOD_ERR_INVALID_SPEAKER,       /* An invalid speaker was passed to this function based on the current speaker mode. */
    FMOD_ERR_INVALID_VECTOR,        /* The vectors passed in are not unit length, or perpendicular. */
    FMOD_ERR_IRX,                   /* PS2 only.  fmodex.irx failed to initialize.  This is most likely because you forgot to load it. */
    FMOD_ERR_MAXAUDIBLE,            /* Reached maximum audible playback count for this sound's soundgroup. */
    FMOD_ERR_MEMORY,                /* Not enough memory or resources. */
    FMOD_ERR_MEMORY_IOP,            /* PS2 only.  Not enough memory or resources on PlayStation 2 IOP ram. */
    FMOD_ERR_MEMORY_SRAM,           /* Not enough memory or resources on console sound ram. */
    FMOD_ERR_MEMORY_CANTPOINT,      /* Can't use FMOD_OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if FMOD_CREATECOMPRESSEDSAMPLE was used. */
    FMOD_ERR_NEEDS2D,               /* Tried to call a command on a 3d sound when the command was meant for 2d sound. */
    FMOD_ERR_NEEDS3D,               /* Tried to call a command on a 2d sound when the command was meant for 3d sound. */
    FMOD_ERR_NEEDSHARDWARE,         /* Tried to use a feature that requires hardware support.  (ie trying to play a VAG compressed sound in software on PS2). */
    FMOD_ERR_NEEDSSOFTWARE,         /* Tried to use a feature that requires the software engine.  Software engine has either been turned off, or command was executed on a hardware channel which does not support this feature. */
    FMOD_ERR_NET_CONNECT,           /* Couldn't connect to the specified host. */
    FMOD_ERR_NET_SOCKET_ERROR,      /* A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere. */
    FMOD_ERR_NET_URL,               /* The specified URL couldn't be resolved. */
    FMOD_ERR_NET_WOULD_BLOCK,       /* Operation on a non-blocking socket could not complete immediately. */
    FMOD_ERR_NOTREADY,              /* Operation could not be performed because specified sound is not ready. */
    FMOD_ERR_OUTPUT_ALLOCATED,      /* Error initializing output device, but more specifically, the output device is already in use and cannot be reused. */
    FMOD_ERR_OUTPUT_CREATEBUFFER,   /* Error creating hardware sound buffer. */
    FMOD_ERR_OUTPUT_DRIVERCALL,     /* A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted. */
    FMOD_ERR_OUTPUT_FORMAT,         /* Soundcard does not support the minimum features needed for this soundsystem (16bit stereo output). */
    FMOD_ERR_OUTPUT_INIT,           /* Error initializing output device. */
    FMOD_ERR_OUTPUT_NOHARDWARE,     /* FMOD_HARDWARE was specified but the sound card does not have the resources nescessary to play it. */
    FMOD_ERR_OUTPUT_NOSOFTWARE,     /* Attempted to create a software sound but no software channels were specified in System::init. */
    FMOD_ERR_PAN,                   /* Panning only works with mono or stereo sound sources. */
    FMOD_ERR_PLUGIN,                /* An unspecified error has been returned from a 3rd party plugin. */
    FMOD_ERR_PLUGIN_MISSING,        /* A requested output, dsp unit type or codec was not available. */
    FMOD_ERR_PLUGIN_RESOURCE,       /* A resource that the plugin requires cannot be found. (ie the DLS file for MIDI playback) */
    FMOD_ERR_PLUGIN_INSTANCES,      /* The number of allowed instances of a plugin has been exceeded. */
    FMOD_ERR_RECORD,                /* An error occured trying to initialize the recording device. */
    FMOD_ERR_REVERB_INSTANCE,       /* Specified Instance in FMOD_REVERB_PROPERTIES couldn't be set. Most likely because another application has locked the EAX4 FX slot. */
    FMOD_ERR_SUBSOUNDS,             /* The error occured because the sound referenced contains subsounds.  (ie you cannot play the parent sound as a static sample, only its subsounds.) */
    FMOD_ERR_SUBSOUND_ALLOCATED,    /* This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first. */
    FMOD_ERR_TAGNOTFOUND,           /* The specified tag could not be found or there are no tags. */
    FMOD_ERR_TOOMANYCHANNELS,       /* The sound created exceeds the allowable input channel count.  This can be increased using the maxinputchannels parameter in System::setSoftwareFormat. */
    FMOD_ERR_UNIMPLEMENTED,         /* Something in FMOD hasn't been implemented when it should be! contact support! */
    FMOD_ERR_UNINITIALIZED,         /* This command failed because System::init or System::setDriver was not called. */
    FMOD_ERR_UNSUPPORTED,           /* A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified. */
    FMOD_ERR_UPDATE,                /* An error caused by System::update occured. */
    FMOD_ERR_VERSION,               /* The version number of this file format is not supported. */

    FMOD_ERR_EVENT_FAILED,          /* An Event failed to be retrieved, most likely due to 'just fail' being specified as the max playbacks behavior. */
    FMOD_ERR_EVENT_INTERNAL,        /* An error occured that wasn't supposed to.  See debug log for reason. */
    FMOD_ERR_EVENT_INFOONLY,        /* Can't execute this command on an EVENT_INFOONLY event. */
    FMOD_ERR_EVENT_MAXSTREAMS,      /* Event failed because 'Max streams' was hit when FMOD_INIT_FAIL_ON_MAXSTREAMS was specified. */
    FMOD_ERR_EVENT_MISMATCH,        /* FSB mis-matches the FEV it was compiled with. */
    FMOD_ERR_EVENT_NAMECONFLICT,    /* A category with the same name already exists. */
    FMOD_ERR_EVENT_NOTFOUND;        /* The requested event, event group, event category or event property could not be found. */

    FMOD_OK = 0;
    FMOD_ERR_ALREADYLOCKED=1;         /* Tried to call lock a second time before unlock was called. */
    FMOD_ERR_BADCOMMAND=2;            /* Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound). */
    FMOD_ERR_CDDA_DRIVERS=3;          /* Neither NTSCSI nor ASPI could be initialised. */
    FMOD_ERR_CDDA_INIT=4;             /* An error occurred while initialising the CDDA subsystem. */
    FMOD_ERR_CDDA_INVALID_DEVICE=5;   /* Couldn't find the specified device. */
    FMOD_ERR_CDDA_NOAUDIO=6;          /* No audio tracks on the specified disc. */
    FMOD_ERR_CDDA_NODEVICES=7;        /* No CD/DVD devices were found. */ 
    FMOD_ERR_CDDA_NODISC=8;           /* No disc present in the specified drive. */
    FMOD_ERR_CDDA_READ=9;             /* A CDDA read error occurred. */
    FMOD_ERR_CHANNEL_ALLOC=10;         /* Error trying to allocate a channel. */
    FMOD_ERR_CHANNEL_STOLEN=11;        /* The specified channel has been reused to play another sound. */
    FMOD_ERR_COM=12;                   /* A Win32 COM related error occured. COM failed to initialize or a QueryInterface failed meaning a Windows codec or driver was not installed properly. */
    FMOD_ERR_DMA=13;                   /* DMA Failure.  See debug output for more information. */
    FMOD_ERR_DSP_CONNECTION=14;        /* DSP connection error.  Connection possibly caused a cyclic dependancy. */
    FMOD_ERR_DSP_FORMAT=15;            /* DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format. */
    FMOD_ERR_DSP_NOTFOUND=16;          /* DSP connection error.  Couldn't find the DSP unit specified. */
    FMOD_ERR_DSP_RUNNING=17;           /* DSP error.  Cannot perform this operation while the network is in the middle of running.  This will most likely happen if a connection or disconnection is attempted in a DSP callback. */
    FMOD_ERR_DSP_TOOMANYCONNECTIONS=18;/* DSP connection error.  The unit being connected to or disconnected should only have 1 input or output. */
    FMOD_ERR_FILE_BAD = 19;              /* Error loading file. Bad password/required password not set*/
    FMOD_ERR_FILE_COULDNOTSEEK=20;     /* Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format. */
    FMOD_ERR_FILE_DISKEJECTED=21;      /* Media was ejected while reading. */
    FMOD_ERR_FILE_EOF=22;              /* End of file unexpectedly reached while trying to read essential data (truncated data?). */
    FMOD_ERR_FILE_NOTFOUND=23;         /* File not found. */
    FMOD_ERR_FILE_UNWANTED=24;         /* Unwanted file access occured. */
    FMOD_ERR_FORMAT=25;                /* Unsupported file or audio format. */
    FMOD_ERR_HTTP=26;                  /* A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere. */
    FMOD_ERR_HTTP_ACCESS=27;           /* The specified resource requires authentication or is forbidden. */
    FMOD_ERR_HTTP_PROXY_AUTH=28;       /* Proxy authentication is required to access the specified resource. */
    FMOD_ERR_HTTP_SERVER_ERROR=29;     /* A HTTP server error occurred. */
    FMOD_ERR_HTTP_TIMEOUT=30;          /* The HTTP request timed out. */
    FMOD_ERR_INITIALIZATION=31;        /* FMOD was not initialized correctly to support this function. */
    FMOD_ERR_INITIALIZED=32;           /* Cannot call this command after System::init. */
    FMOD_ERR_INTERNAL=33;              /* An error occured that wasn't supposed to.  Contact support. */
    FMOD_ERR_INVALID_ADDRESS=34;       /* On Xbox 360, this memory address passed to FMOD must be physical, (ie allocated with XPhysicalAlloc.) */
    FMOD_ERR_INVALID_FLOAT=35;         /* Value passed in was a NaN, Inf or denormalized float. */
    FMOD_ERR_INVALID_HANDLE=36;        /* An invalid object handle was used. */
    FMOD_ERR_INVALID_PARAM=37;         /* An invalid parameter was passed to this function. */
    FMOD_ERR_INVALID_SPEAKER=38;       /* An invalid speaker was passed to this function based on the current speaker mode. */
    FMOD_ERR_INVALID_VECTOR=39;        /* The vectors passed in are not unit length, or perpendicular. */
    FMOD_ERR_IRX=40;                   /* PS2 only.  fmodex.irx failed to initialize.  This is most likely because you forgot to load it. */
    FMOD_ERR_MAXAUDIBLE=41;            /* Reached maximum audible playback count for this sound's soundgroup. */
    FMOD_ERR_MEMORY=42;                /* Not enough memory or resources. */
    FMOD_ERR_MEMORY_IOP=43;            /* PS2 only.  Not enough memory or resources on PlayStation 2 IOP ram. */
    FMOD_ERR_MEMORY_SRAM=44;           /* Not enough memory or resources on console sound ram. */
    FMOD_ERR_MEMORY_CANTPOINT=45;      /* Can't use FMOD_OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if FMOD_CREATECOMPRESSEDSAMPLE was used. */
    FMOD_ERR_NEEDS2D=46;               /* Tried to call a command on a 3d sound when the command was meant for 2d sound. */
    FMOD_ERR_NEEDS3D=47;               /* Tried to call a command on a 2d sound when the command was meant for 3d sound. */
    FMOD_ERR_NEEDSHARDWARE=48;         /* Tried to use a feature that requires hardware support.  (ie trying to play a VAG compressed sound in software on PS2). */
    FMOD_ERR_NEEDSSOFTWARE=49;         /* Tried to use a feature that requires the software engine.  Software engine has either been turned off, or command was executed on a hardware channel which does not support this feature. */
    FMOD_ERR_NET_CONNECT=50;           /* Couldn't connect to the specified host. */
    FMOD_ERR_NET_SOCKET_ERROR=51;      /* A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere. */
    FMOD_ERR_NET_URL=52;               /* The specified URL couldn't be resolved. */
    FMOD_ERR_NET_WOULD_BLOCK=53;       /* Operation on a non-blocking socket could not complete immediately. */
    FMOD_ERR_NOTREADY=54;              /* Operation could not be performed because specified sound is not ready. */
    FMOD_ERR_OUTPUT_ALLOCATED=55;      /* Error initializing output device, but more specifically, the output device is already in use and cannot be reused. */
    FMOD_ERR_OUTPUT_CREATEBUFFER=56;   /* Error creating hardware sound buffer. */
    FMOD_ERR_OUTPUT_DRIVERCALL=57;     /* A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted. */
    FMOD_ERR_OUTPUT_FORMAT=58;         /* Soundcard does not support the minimum features needed for this soundsystem (16bit stereo output). */
    FMOD_ERR_OUTPUT_INIT=59;           /* Error initializing output device. */
    FMOD_ERR_OUTPUT_NOHARDWARE=60;     /* FMOD_HARDWARE was specified but the sound card does not have the resources nescessary to play it. */
    FMOD_ERR_OUTPUT_NOSOFTWARE=61;     /* Attempted to create a software sound but no software channels were specified in System::init. */
    FMOD_ERR_PAN=62;                   /* Panning only works with mono or stereo sound sources. */
    FMOD_ERR_PLUGIN=63;                /* An unspecified error has been returned from a 3rd party plugin. */
    FMOD_ERR_PLUGIN_MISSING=64;        /* A requested output, dsp unit type or codec was not available. */
    FMOD_ERR_PLUGIN_RESOURCE=65;       /* A resource that the plugin requires cannot be found. (ie the DLS file for MIDI playback) */
    FMOD_ERR_PLUGIN_INSTANCES=66;      /* The number of allowed instances of a plugin has been exceeded. */
    FMOD_ERR_RECORD=67;                /* An error occured trying to initialize the recording device. */
    FMOD_ERR_REVERB_INSTANCE=68;       /* Specified Instance in FMOD_REVERB_PROPERTIES couldn't be set. Most likely because another application has locked the EAX4 FX slot. */
    FMOD_ERR_SUBSOUNDS=69;             /* The error occured because the sound referenced contains subsounds.  (ie you cannot play the parent sound as a static sample, only its subsounds.) */
    FMOD_ERR_SUBSOUND_ALLOCATED=70;    /* This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first. */
    FMOD_ERR_TAGNOTFOUND=71;           /* The specified tag could not be found or there are no tags. */
    FMOD_ERR_TOOMANYCHANNELS=72;       /* The sound created exceeds the allowable input channel count.  This can be increased using the maxinputchannels parameter in System::setSoftwareFormat. */
    FMOD_ERR_UNIMPLEMENTED=73;         /* Something in FMOD hasn't been implemented when it should be! contact support! */
    FMOD_ERR_UNINITIALIZED=74;         /* This command failed because System::init or System::setDriver was not called. */
    FMOD_ERR_UNSUPPORTED=75;           /* A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified. */
    FMOD_ERR_UPDATE=76;                /* An error caused by System::update occured. */
    FMOD_ERR_VERSION=77;               /* The version number of this file format is not supported. */

    FMOD_ERR_EVENT_FAILED=78;          /* An Event failed to be retrieved, most likely due to 'just fail' being specified as the max playbacks behavior. */
    FMOD_ERR_EVENT_INTERNAL=79;        /* An error occured that wasn't supposed to.  See debug log for reason. */
    FMOD_ERR_EVENT_INFOONLY=80;        /* Can't execute this command on an EVENT_INFOONLY event. */
    FMOD_ERR_EVENT_MAXSTREAMS=81;      /* Event failed because 'Max streams' was hit when FMOD_INIT_FAIL_ON_MAXSTREAMS was specified. */
    FMOD_ERR_EVENT_MISMATCH=82;        /* FSB mis-matches the FEV it was compiled with. */
    FMOD_ERR_EVENT_NAMECONFLICT=83;    /* A category with the same name already exists. */
    FMOD_ERR_EVENT_NOTFOUND=84;        /* The requested event, event group, event category or event property could not be found. */


    switch (argument0)
    {
        case FMOD_ERR_ALREADYLOCKED:          return "Tried to call lock a second time before unlock was called. ";
        case FMOD_ERR_BADCOMMAND:             return "Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound). ";
        case FMOD_ERR_CDDA_DRIVERS:           return "Neither NTSCSI nor ASPI could be initialised. ";
        case FMOD_ERR_CDDA_INIT:              return "An error occurred while initialising the CDDA subsystem. ";
        case FMOD_ERR_CDDA_INVALID_DEVICE:    return "Couldn't find the specified device. ";
        case FMOD_ERR_CDDA_NOAUDIO:           return "No audio tracks on the specified disc. ";
        case FMOD_ERR_CDDA_NODEVICES:         return "No CD/DVD devices were found. ";
        case FMOD_ERR_CDDA_NODISC:            return "No disc present in the specified drive. ";
        case FMOD_ERR_CDDA_READ:              return "A CDDA read error occurred. ";
        case FMOD_ERR_CHANNEL_ALLOC:          return "Error trying to allocate a channel. ";
        case FMOD_ERR_CHANNEL_STOLEN:         return "The specified channel has been reused to play another sound. ";
        case FMOD_ERR_COM:                    return "A Win32 COM related error occured. COM failed to initialize or a QueryInterface failed meaning a Windows codec or driver was not installed properly. ";
        case FMOD_ERR_DMA:                    return "DMA Failure.  See debug output for more information. ";
        case FMOD_ERR_DSP_CONNECTION:         return "DSP connection error.  Connection possibly caused a cyclic dependancy. ";
        case FMOD_ERR_DSP_FORMAT:             return "DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format. ";
        case FMOD_ERR_DSP_NOTFOUND:           return "DSP connection error.  Couldn't find the DSP unit specified. ";
        case FMOD_ERR_DSP_RUNNING:            return "DSP error.  Cannot perform this operation while the network is in the middle of running.  This will most likely happen if a connection or disconnection is attempted in a DSP callback. ";
        case FMOD_ERR_DSP_TOOMANYCONNECTIONS: return "DSP connection error.  The unit being connected to or disconnected should only have 1 input or output. ";
        case FMOD_ERR_EVENT_FAILED:           return "An Event failed to be retrieved, most likely due to 'just fail' being specified as the max playbacks behavior. ";
        case FMOD_ERR_EVENT_INFOONLY:         return "Can't execute this command on an EVENT_INFOONLY event. ";
        case FMOD_ERR_EVENT_INTERNAL:         return "An error occured that wasn't supposed to.  See debug log for reason. ";
        case FMOD_ERR_EVENT_MAXSTREAMS:       return "Event failed because 'Max streams' was hit when FMOD_INIT_FAIL_ON_MAXSTREAMS was specified. ";
        case FMOD_ERR_EVENT_MISMATCH:         return "FSB mis-matches the FEV it was compiled with. ";
        case FMOD_ERR_EVENT_NAMECONFLICT:     return "A category with the same name already exists. ";
        case FMOD_ERR_EVENT_NOTFOUND:         return "The requested event, event group, event category or event property could not be found. ";
        case FMOD_ERR_FILE_BAD:               return "Error loading file. ";
        case FMOD_ERR_FILE_COULDNOTSEEK:      return "Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format. ";
        case FMOD_ERR_FILE_DISKEJECTED:       return "Media was ejected while reading. ";
        case FMOD_ERR_FILE_EOF:               return "End of file unexpectedly reached while trying to read essential data (truncated data?). ";
        case FMOD_ERR_FILE_NOTFOUND:          return "File not found. ";
        case FMOD_ERR_FILE_UNWANTED:          return "Unwanted file access occured. ";
        case FMOD_ERR_FORMAT:                 return "Unsupported file or audio format. ";
        case FMOD_ERR_HTTP:                   return "A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere. ";
        case FMOD_ERR_HTTP_ACCESS:            return "The specified resource requires authentication or is forbidden. ";
        case FMOD_ERR_HTTP_PROXY_AUTH:        return "Proxy authentication is required to access the specified resource. ";
        case FMOD_ERR_HTTP_SERVER_ERROR:      return "A HTTP server error occurred. ";
        case FMOD_ERR_HTTP_TIMEOUT:           return "The HTTP request timed out. ";
        case FMOD_ERR_INITIALIZATION:         return "FMOD was not initialized correctly to support this function. ";
        case FMOD_ERR_INITIALIZED:            return "Cannot call this command after System::init. ";
        case FMOD_ERR_INTERNAL:               return "An error occured that wasn't supposed to.  Contact support. ";
        case FMOD_ERR_INVALID_ADDRESS:        return "On Xbox 360, this memory address passed to FMOD must be physical, (ie allocated with XPhysicalAlloc.) ";
        case FMOD_ERR_INVALID_FLOAT:          return "Value passed in was a NaN, Inf or denormalized float. ";
        case FMOD_ERR_INVALID_HANDLE:         return "An invalid object handle was used. ";
        case FMOD_ERR_INVALID_PARAM:          return "An invalid parameter was passed to this function. ";
        case FMOD_ERR_INVALID_SPEAKER:        return "An invalid speaker was passed to this function based on the current speaker mode. ";
        case FMOD_ERR_INVALID_VECTOR:         return "The vectors passed in are not unit length, or perpendicular. ";
        case FMOD_ERR_IRX:                    return "PS2 only.  fmodex.irx failed to initialize.  This is most likely because you forgot to load it. ";
        case FMOD_ERR_MAXAUDIBLE:             return "Reached maximum audible playback count for this sound's soundgroup. ";
        case FMOD_ERR_MEMORY:                 return "Not enough memory or resources. ";
        case FMOD_ERR_MEMORY_CANTPOINT:       return "Can't use FMOD_OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if FMOD_CREATECOMPRESSEDSAMPLE was used. ";
        case FMOD_ERR_MEMORY_IOP:             return "PS2 only.  Not enough memory or resources on PlayStation 2 IOP ram. ";
        case FMOD_ERR_MEMORY_SRAM:            return "Not enough memory or resources on console sound ram. ";
        case FMOD_ERR_NEEDS2D:                return "Tried to call a command on a 3d sound when the command was meant for 2d sound. ";
        case FMOD_ERR_NEEDS3D:                return "Tried to call a command on a 2d sound when the command was meant for 3d sound. ";
        case FMOD_ERR_NEEDSHARDWARE:          return "Tried to use a feature that requires hardware support.  (ie trying to play a VAG compressed sound in software on PS2). ";
        case FMOD_ERR_NEEDSSOFTWARE:          return "Tried to use a feature that requires the software engine.  Software engine has either been turned off, or command was executed on a hardware channel which does not support this feature. ";
        case FMOD_ERR_NET_CONNECT:            return "Couldn't connect to the specified host. ";
        case FMOD_ERR_NET_SOCKET_ERROR:       return "A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere. ";
        case FMOD_ERR_NET_URL:                return "The specified URL couldn't be resolved. ";
        case FMOD_ERR_NET_WOULD_BLOCK:        return "Operation on a non-blocking socket could not complete immediately. ";
        case FMOD_ERR_NOTREADY:               return "Operation could not be performed because specified sound is not ready. ";
        case FMOD_ERR_OUTPUT_ALLOCATED:       return "Error initializing output device, but more specifically, the output device is already in use and cannot be reused. ";
        case FMOD_ERR_OUTPUT_CREATEBUFFER:    return "Error creating hardware sound buffer. ";
        case FMOD_ERR_OUTPUT_DRIVERCALL:      return "A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted. ";
        case FMOD_ERR_OUTPUT_FORMAT:          return "Soundcard does not support the minimum features needed for this soundsystem (16bit stereo output). ";
        case FMOD_ERR_OUTPUT_INIT:            return "Error initializing output device. ";
        case FMOD_ERR_OUTPUT_NOHARDWARE:      return "FMOD_HARDWARE was specified but the sound card does not have the resources nescessary to play it. ";
        case FMOD_ERR_OUTPUT_NOSOFTWARE:      return "Attempted to create a software sound but no software channels were specified in System::init. ";
        case FMOD_ERR_PAN:                    return "Panning only works with mono or stereo sound sources. ";
        case FMOD_ERR_PLUGIN:                 return "An unspecified error has been returned from a 3rd party plugin. ";
        case FMOD_ERR_PLUGIN_INSTANCES:       return "The number of allowed instances of a plugin has been exceeded. ";
        case FMOD_ERR_PLUGIN_MISSING:         return "A requested output, dsp unit type or codec was not available. ";
        case FMOD_ERR_PLUGIN_RESOURCE:        return "A resource that the plugin requires cannot be found. (ie the DLS file for MIDI playback) ";
        case FMOD_ERR_RECORD:                 return "An error occured trying to initialize the recording device. ";
        case FMOD_ERR_REVERB_INSTANCE:        return "Specified Instance in FMOD_REVERB_PROPERTIES couldn't be set. Most likely because another application has locked the EAX4 FX slot. ";
        case FMOD_ERR_SUBSOUNDS:              return "The error occured because the sound referenced contains subsounds.  (ie you cannot play the parent sound as a static sample, only its subsounds.) ";
        case FMOD_ERR_SUBSOUND_ALLOCATED:     return "This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first. ";
        case FMOD_ERR_TAGNOTFOUND:            return "The specified tag could not be found or there are no tags. ";
        case FMOD_ERR_TOOMANYCHANNELS:        return "The sound created exceeds the allowable input channel count.  This can be increased using the maxinputchannels parameter in System::setSoftwareFormat. ";
        case FMOD_ERR_UNIMPLEMENTED:          return "Something in FMOD hasn't been implemented when it should be! contact support! ";
        case FMOD_ERR_UNINITIALIZED:          return "This command failed because System::init or System::setDriver was not called. ";
        case FMOD_ERR_UNSUPPORTED:            return "A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified. ";
        case FMOD_ERR_UPDATE:                 return "An error caused by System::update occured. ";
        case FMOD_ERR_VERSION:                return "The version number of this file format is not supported. ";
        case FMOD_OK:                         return "No errors.";
        default :                             return "Unknown error.";
    };