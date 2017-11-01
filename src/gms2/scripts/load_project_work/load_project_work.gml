if (idbyte == 104) or(idbyte == 103) or (idbyte == 101) or (idbyte == 102)
{
    for (j = global.loading_current; j < global.loading_end;j++)
    {
        if (get_timer()-global.loadingtimeprev >= 100000)
        {
            global.loading_current = j;
            global.loadingtimeprev = get_timer();
            return 0;
        }
            
        var layertemp = ds_list_create();
        var t_env_list = ds_list_create();
        ds_list_add(layertemp, t_env_list);
        ds_list_add(layertemp, ds_list_create());
        ds_list_add(layer_list, layertemp);
        
        //object data
        numofobjects = buffer_read(load_buffer,buffer_u32);
        for (i = 0; i < numofobjects;i++)
        {
            objectlist = ds_list_create();
            ds_list_add(objectlist,round(buffer_read(load_buffer,buffer_u32)));
            
            objectbuffersize = buffer_read(load_buffer,buffer_u32);
            objectbuffer = buffer_create(objectbuffersize,buffer_fixed,1);
            ds_list_add(objectlist,objectbuffer);
            buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
            buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
            
            objectinfolist = ds_list_create();
            ds_list_add(objectlist,objectinfolist);
            ds_list_add(objectinfolist,round(buffer_read(load_buffer,buffer_u32)));
            ds_list_add(objectinfolist,-1);
            ds_list_add(objectinfolist,round(buffer_read(load_buffer,buffer_u32)));
            
            ds_list_add(layertemp[| 1],objectlist);
        }
        
        //envelopes
        numofenvelopes = buffer_read(load_buffer,buffer_u32);
        repeat (numofenvelopes)
        {
            var t_env = ds_list_create();
            ds_list_add(t_env_list,t_env);
            
            ds_list_add(t_env,buffer_read(load_buffer,buffer_string));
            
            var t_time_list_size = buffer_read(load_buffer,buffer_u32);
            var t_time_list = ds_list_create();
            ds_list_add(t_env,t_time_list);
            repeat (t_time_list_size)
            {
                ds_list_add(t_time_list,buffer_read(load_buffer,buffer_u32));
            }
            var t_data_list_size = buffer_read(load_buffer,buffer_u32);
            var t_data_list = ds_list_create();
            ds_list_add(t_env,t_data_list);
            repeat (t_data_list_size)
                ds_list_add(t_data_list,buffer_read(load_buffer,buffer_u8));
                
            ds_list_add(t_env,buffer_read(load_buffer,buffer_u8));
            ds_list_add(t_env,buffer_read(load_buffer,buffer_u8));
            
            //reserved space
            repeat (5)
                buffer_read(load_buffer,buffer_u8);
        }
        
        //layer vars
        if (idbyte == 103) or (idbyte == 104)
        {
            ds_list_add(layertemp, buffer_read(load_buffer,buffer_u8)); //muted
            ds_list_add(layertemp, buffer_read(load_buffer,buffer_u8)); //hidden
            ds_list_add(layertemp, buffer_read(load_buffer,buffer_string)); //name
            repeat (16)
                buffer_read(load_buffer,buffer_u32); //reserved
                
            var t_daclist = ds_list_create();
            ds_list_add(layertemp, t_daclist);
            numofdacs = buffer_read(load_buffer,buffer_u8);
            repeat (numofdacs)
            {
                var t_thisdaclist = ds_list_create();
                ds_list_add(t_daclist, t_thisdaclist);
                ds_list_add(t_thisdaclist, -1);
                ds_list_add(t_thisdaclist, buffer_read(load_buffer,buffer_string));
                ds_list_add(t_thisdaclist, buffer_read(load_buffer,buffer_string));
            }
        }
        else
        {
            ds_list_add(layertemp, 0);
            ds_list_add(layertemp, 0);
            ds_list_add(layertemp, "Layer "+string(j+1));
            ds_list_add(layertemp, ds_list_create());
        }
    }
}
else if (idbyte == 100) //old, need to remake buffers
{
    for (j = global.loading_current; j < global.loading_end;j++)
    {
        if (get_timer()-global.loadingtimeprev >= 100000)
        {
            global.loading_current = j;
            global.loadingtimeprev = get_timer();
            return 0;
        }
        layertemp = ds_list_create();
        ds_list_add(layertemp,ds_list_create());
        ds_list_add(layertemp,ds_list_create());
        ds_list_add(layer_list,layertemp);
        
        numofobjects = buffer_read(load_buffer,buffer_u32);
        for (i = 0; i < numofobjects;i++)
        {
            objectlist = ds_list_create();
            ds_list_add(objectlist,round(buffer_read(load_buffer,buffer_u32)));
            
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
            ds_list_add(objectinfolist,round(buffer_read(load_buffer,buffer_u32)));
            ds_list_add(objectinfolist,-1);
            ds_list_add(objectinfolist,round(buffer_read(load_buffer,buffer_u32)));
            
            ds_list_add(layertemp[| 1],objectlist);
        }
        
        ds_list_add(layertemp, 0);
        ds_list_add(layertemp, 0);
        ds_list_add(layertemp, "Layer "+string(j+1));
        ds_list_add(layertemp, ds_list_create());
    }
}
    
if (get_timer()-global.loadingtimeprev >= 100000)
{
    global.loading_current = j;
    global.loadingtimeprev = get_timer();
    return 0;
}
    
if (songload)
{
    songfile_name = buffer_read(load_buffer, buffer_string);
    songfile = songfile_name;
    songfile_size = buffer_read(load_buffer, buffer_u32);
    song_buffer = buffer_create(songfile_size, buffer_fixed, 1);
    buffer_copy(load_buffer ,buffer_tell(load_buffer), songfile_size, song_buffer,0);
    buffer_seek(load_buffer, buffer_seek_relative, songfile_size);
	
	var t_exInfo = buffer_create(34*8, buffer_fixed, 8);
	buffer_fill(t_exInfo, 0, buffer_u64, 0, buffer_get_size(t_exInfo));
	buffer_poke(t_exInfo, 0, buffer_u32, buffer_get_size(song_buffer));
	song = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(song_buffer),	FMODGMS_MODE_DEFAULT | 
																		FMODGMS_MODE_OPENMEMORY_POINT | 
																		FMODGMS_MODE_ACCURATETIME |
																		FMODGMS_MODE_CREATECOMPRESSEDSAMPLE, 
																		buffer_get_address(t_exInfo));
   
    if (song == -1) 
    {
        show_message_new("Failed to load audio: "+FMODGMS_Util_GetErrorMessage());
    }
    else
    {
        if (idbyte < 103)
            parsingaudio = 1;
        else
            parsingaudio = parsingaudioload;
			
		FMODGMS_Snd_PlaySound(song, play_sndchannel);
        apply_audio_settings();
		fmod_set_pos(play_sndchannel, 0);
		
		if (parsingaudio)
		{
			song_parse = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(song_buffer),	FMODGMS_MODE_DEFAULT | 
																					FMODGMS_MODE_ACCURATETIME |
																					FMODGMS_MODE_OPENMEMORY_POINT | 
																					FMODGMS_MODE_CREATESTREAM |
																					FMODGMS_MODE_OPENONLY, 
																					buffer_get_address(t_exInfo));
		}
		
		song_samplerate = FMODGMS_Snd_Get_DefaultFrequency(song);
		
		songlength = fmod_get_length(song);
		if (length < songlength/1000*projectfps)
		{
		    length = ceil(songlength/1000*projectfps);
		    endframe = length;
		}
    }
	
    if (buffer_exists(audio_buffer))
		buffer_delete(audio_buffer);
	audio_buffer = -1;
    deltatime = 0;
    playing = 0;
	parsingaudio_pos = 0;
    tlpos = 0;
	tlx = 0;
        
    //audio data
    if (!parsingaudioload)
    {
        parsinglistsize = buffer_read(load_buffer,buffer_u32);
		if (idbyte == 104)
		{
		    audio_buffer = buffer_create(parsinglistsize, buffer_fast, 1);
		    buffer_copy(load_buffer, buffer_tell(load_buffer), parsinglistsize, audio_buffer, 0);
		    buffer_seek(load_buffer, buffer_seek_relative, parsinglistsize);
		}
        else if (idbyte == 103)
        {
			parsingaudio = 1;
			song_parse = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(song_buffer),	FMODGMS_MODE_DEFAULT | 
																					FMODGMS_MODE_ACCURATETIME |
																					FMODGMS_MODE_OPENMEMORY_POINT | 
																					FMODGMS_MODE_CREATESTREAM |
																					FMODGMS_MODE_OPENONLY, 
																					buffer_get_address(t_exInfo));
			for (i = 0; i < parsinglistsize; i++)
            {
                buffer_read(load_buffer,buffer_f32); //skip
            }        
		}
        else
        {
            for (i = 0; i < parsinglistsize; i++)
            {
                buffer_read(load_buffer,buffer_f32); //skip
            }
        }
    }
}

buffer_delete(t_exInfo);
    
//markers
parsinglistsize = buffer_read(load_buffer,buffer_u32);
for (i = 0; i < parsinglistsize; i++)
{
    ds_list_add(marker_list,buffer_read(load_buffer,buffer_u32));
}
    
buffer_delete(load_buffer);

projectorlist_update();
timeline_surf_length = 0;

global.loading_loadproject = 0;

room_goto(rm_seq);
