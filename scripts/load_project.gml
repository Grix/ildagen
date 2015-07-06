//loads project igp file
file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;
    
clear_project();

FS_file_copy(file_loc,controller.FStemp+filename_name(file_loc));
    
load_buffer = buffer_load("temp\"+filename_name(file_loc));
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 100)
    {
    show_message_async("Unexpected byte, is this a valid LasershowGen project file?");
    exit;
    }
    
projectfps = buffer_read(load_buffer,buffer_u8);
songload = buffer_read(load_buffer,buffer_u8);
parsingaudioload = buffer_read(load_buffer,buffer_u8);
startframe = buffer_read(load_buffer,buffer_u32);
endframe = buffer_read(load_buffer,buffer_u32);
length = endframe+50;
buffer_seek(load_buffer,buffer_seek_start,50);

maxlayers = buffer_read(load_buffer,buffer_u32);
for (j = 0; j < maxlayers;j++)
    {
    layertemp = ds_list_create();
    ds_list_add(layer_list,layertemp);
    
    numofobjects = buffer_read(load_buffer,buffer_u32);
    for (i = 0; i < numofobjects;i++)
        {
        objectlist = ds_list_create();
        ds_list_add(objectlist,buffer_read(load_buffer,buffer_u32));
        
        objectbuffersize = buffer_read(load_buffer,buffer_u32);
        objectbuffer = buffer_create(objectbuffersize,buffer_fixed,1);
        ds_list_add(objectlist,objectbuffer);
        buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
        buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
        
        objectinfolist = ds_list_create();
        ds_list_add(objectlist,objectinfolist);
        ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_u32));
        ds_list_add(objectinfolist,-1);
        ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_u32));
        
        ds_list_add(layertemp,objectlist);
        }
    }
    
if (songload)
    {
    songfile_name = buffer_read(load_buffer,buffer_string);
    songfile = songfile_name;
    songfile_size = buffer_read(load_buffer,buffer_u32);
    songfile_buffer = buffer_create(songfile_size,buffer_fixed,1);
    buffer_copy(load_buffer,buffer_tell(load_buffer),songfile_size,songfile_buffer,0);
    buffer_seek(load_buffer,buffer_seek_relative,songfile_size);
    buffer_save(songfile_buffer,"temp/song");
    FS_file_copy(controller.FStemp+"song",songfile);
    songfile = songfile_name;
    
    buffer_delete(songfile_buffer);
        
    songinstance = 0;
    show_debug_message(songfile);
    song = FMODSoundAdd(songfile,0,0);
    if (!song) 
        {
        show_message_async("Failed to load audio: "+FMODErrorStr(FMODGetLastError()));
        buffer_delete(load_buffer);
        ds_list_clear(audio_list);
        playing = 0;
        parsingaudio = 0;
        tlpos = 0;
        exit;
        }
    songlength = FMODSoundGetLength(song);
    if (length < songlength/1000*projectfps)
        {
        length = songlength/1000*projectfps;
        }
    FMODSoundSetGroup(song, 1);
    
    ds_list_clear(audio_list);
    parseinstance = FMODSoundPlay(song,0);
    FMODInstanceSetMuted(parseinstance,1);
    parsingaudio = parsingaudioload;
    errorcheck = 0;
    deltatime = 0;    
    playing = 0;
    tlpos = 0;
    
    songinstance = FMODSoundPlay(song,1);
    
    set_audio_speed();
    
    }
    

    
//audio data
if (!parsingaudioload)
    {
    parsinglistsize = buffer_read(load_buffer,buffer_u32);
    for (i = 0; i < parsinglistsize; i++)
        {
        ds_list_add(audio_list,buffer_read(load_buffer,buffer_f32));
        }
    }
//markers
parsinglistsize = buffer_read(load_buffer,buffer_u32);
    for (i = 0; i < parsinglistsize; i++)
        {
        ds_list_add(marker_list,buffer_read(load_buffer,buffer_u32));
        }
    
buffer_delete(load_buffer);
