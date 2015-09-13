//loads project igp file
file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;
    
clear_project();

load_buffer = buffer_load(file_loc);
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 100) and (idbyte != 101)
    {
    show_message_async("Unexpected ID byte, is this a valid LasershowGen project file?");
    exit;
    }
    
projectfps = buffer_read(load_buffer,buffer_u8);
songload = buffer_read(load_buffer,buffer_u8);
parsingaudioload = buffer_read(load_buffer,buffer_u8);
startframe = buffer_read(load_buffer,buffer_u32);
endframe = buffer_read(load_buffer,buffer_u32);
length = endframe+50;
buffer_seek(load_buffer,buffer_seek_start,50);

if (idbyte == 101)
    {
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
        numofparameters = buffer_read(load_buffer,buffer_u32);
        }
    }
else if (idbyte == 100) //old, need to remake buffers
    {
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
            buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
            buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
            bufferpos = buffer_tell(load_buffer);
            
            //remake
            buffer_seek(objectbuffer,buffer_seek_start,0);
            bufferver = buffer_read(objectbuffer,buffer_u8);
            new_objectbuffer = buffer_create(1,buffer_grow,1);
            ds_list_add(objectlist,new_objectbuffer);
            buffer_copy(objectbuffer,0,50,new_objectbuffer,0);
            buffer_seek(objectbuffer,buffer_seek_start,50);
            buffer_seek(new_objectbuffer,buffer_seek_start,50);
            for (u = 50; u >= objectbuffersize; u += 6)
                {
                buffer_write(new_objectbuffer,buffer_f32,buffer_read(objectbuffer,buffer_f32));
                buffer_write(new_objectbuffer,buffer_f32,buffer_read(objectbuffer,buffer_f32));
                buffer_write(new_objectbuffer,buffer_bool,buffer_read(objectbuffer,buffer_bool));
                buffer_write(new_objectbuffer,buffer_u32,make_colour_rgb(buffer_read(objectbuffer,buffer_u8),
                                                                        buffer_read(objectbuffer,buffer_u8),
                                                                        buffer_read(objectbuffer,buffer_u8)));
                }
            buffer_delete(objectbuffer);
            
            objectinfolist = ds_list_create();
            ds_list_add(objectlist,objectinfolist);
            ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_u32));
            ds_list_add(objectinfolist,-1);
            ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_u32));
            
            ds_list_add(layertemp,objectlist);
            }
        }
    }
    
if (songload)
    {
    songfile_name = buffer_read(load_buffer,buffer_string);
    songfile = songfile_name;
    songfile_size = buffer_read(load_buffer,buffer_u32);
    song_buffer = buffer_create(songfile_size,buffer_fixed,1);
    buffer_copy(load_buffer,buffer_tell(load_buffer),songfile_size,song_buffer,0);
    buffer_seek(load_buffer,buffer_seek_relative,songfile_size);
    buffer_save(song_buffer,"temp\"+songfile);
        
    songinstance = 0;
    song = FMODSoundAdd(controller.FStemp+songfile,0,0);
    if (!song) 
        {
        show_message_async("Failed to load audio: "+FMODErrorStr(FMODGetLastError()));
        }
    else
        {
        songlength = FMODSoundGetLength(song);
        if (length < songlength/1000*projectfps)
            {
            length = songlength/1000*projectfps;
            }
        FMODSoundSetGroup(song, 1);
        FMODInstanceSetVolume(seqcontrol.songinstance,seqcontrol.volume/100);
        
        parseinstance = FMODSoundPlay(song,0);
        FMODInstanceSetMuted(parseinstance,1);
        parsingaudio = parsingaudioload;
        }
    ds_list_clear(audio_list);
    errorcheck = 0;
    deltatime = 0;    
    playing = 0;
    tlpos = 0;
    
    if (song)
        {
        songinstance = FMODSoundPlay(song,1);
        
        set_audio_speed();
        }
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
