//loads project igp file
file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;
    
clear_project();

//tempname = FS_unique_fname(working_directory,".igf");
//FS_file_copy(file_loc,tempname);
load_buffer = buffer_load(FS_copy_fast(file_loc));
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 50)
    {
    show_message_async("Unexpected byte, is this a valid ildaGen project file?");
    exit;
    }
    
projectfps = buffer_read(load_buffer,buffer_u8);
songload = buffer_read(load_buffer,buffer_u8);
parsingaudioload = buffer_read(load_buffer,buffer_u8);
buffer_seek(load_buffer,buffer_seek_start,50);

maxlayers = buffer_read(load_buffer,buffer_u32);
for (j = 0; j < maxlayers;j++)
    {
    layertemp = ds_list_create();
    ds_list_add(layer_list,layertemp);
    
    numofobjects = buffer_read(load_buffer,buffer_u32);
    for (i = 0; i < numofobjects;i++)
        {
        ds_list_add(layertemp,buffer_read(load_buffer,buffer_u32));
        
        objectbuffersize = buffer_read(load_buffer,buffer_u32);
        objectbuffer = buffer_create(objectbuffersize,buffer_fixed,1);
        ds_list_add(layertemp,objectbuffer);
        buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
        buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
        
        objectinfolist = ds_list_create();
        ds_list_add(layertemp,objectinfolist);
        ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_u32));
        ds_list_add(objectinfolist,-1);
        ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_u32));
        }
    }
    
if (songload)
    {
    songfile_name = buffer_read(load_buffer,buffer_string);
    songfile_size = buffer_read(load_buffer,buffer_u32);
    //if !(FS_file_exists(working_directory+songfile_name))
        //{
        songfile_tempname = FS_unique_fname(working_directory,filename_ext(songfile_name));
        songfile_instance = FS_file_bin_open(songfile_tempname,1);
        FS_file_bin_write_flush(songfile_instance);
        for (i = 0; i < songfile_size; i++)
            {
            FS_file_bin_write_byte(songfile_instance,buffer_read(load_buffer,buffer_u8));
            }
        FS_file_bin_close(songfile_instance);
        //}
        
    songinstance = 0;
    songfile = songfile_tempname;
    song = FMODSoundAdd(songfile,0,0);
    if (!song) 
        {
        show_message_async("Failed to load audio: "+FMODErrorStr(FMODGetLastError()));
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
    
if (!parsingaudioload)
    {
    parsinglistsize = buffer_read(load_buffer,buffer_u32);
    for (i = 0; i < parsinglistsize; i++)
        {
        ds_list_add(audio_list,buffer_read(load_buffer,buffer_f32));
        }
    }
    