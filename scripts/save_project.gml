//exports project into igp file

playing = 0;
if (song)
    FMODInstanceSetPaused(songinstance,1);
    
save_buffer = buffer_create(1,buffer_grow,1);

file_loc = get_save_filename_ext("*.igp","example.igp","","Select LasershowGen project file location");
if (file_loc == "")
    exit;
    
length = ceil(length);
    
buffer_write(save_buffer,buffer_u8,101); //version / ID
buffer_write(save_buffer,buffer_u8,projectfps); //fps
buffer_write(save_buffer,buffer_u8,song); //audio enabled
buffer_write(save_buffer,buffer_u8,parsingaudio); //audio still parsing
buffer_write(save_buffer,buffer_u32,startframe);
buffer_write(save_buffer,buffer_u32,endframe);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
repeat (30)
    buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_s32,ds_list_size(layer_list)); //pos 50


for (i = 0; i < ds_list_size(layer_list); i++)
    {
    layer = ds_list_find_value(layer_list,i);
    buffer_write(save_buffer,buffer_u32,ds_list_size(layer));
    for (j = 0; j < ds_list_size(layer); j++)
        {
        objectlist = ds_list_find_value(layer,j);
        tempframe = ds_list_find_value(objectlist,0);
        tempbuffer = ds_list_find_value(objectlist,1);
        tempinfolist = ds_list_find_value(objectlist,2);
        buffer_write(save_buffer,buffer_u32,tempframe);
        buffer_write(save_buffer,buffer_u32,buffer_get_size(tempbuffer));
        buffer_copy(tempbuffer,0,buffer_get_size(tempbuffer),save_buffer,buffer_tell(save_buffer));
        buffer_seek(save_buffer,buffer_seek_relative,buffer_get_size(tempbuffer));
        buffer_write(save_buffer,buffer_u32,ds_list_find_value(tempinfolist,0));
        buffer_write(save_buffer,buffer_u32,ds_list_find_value(tempinfolist,2));
        }
    buffer_write(save_buffer,buffer_u32,0);
    }

if (song)
    {
    buffer_write(save_buffer,buffer_string,songfile_name);
    songfile_size = buffer_get_size(song_buffer);
    buffer_write(save_buffer,buffer_u32,songfile_size);
    buffer_copy(song_buffer,0,songfile_size,save_buffer,buffer_tell(save_buffer));
    buffer_seek(save_buffer,buffer_seek_relative,songfile_size);
    
    if (!parsingaudio)
        {
        buffer_write(save_buffer,buffer_u32,ds_list_size(audio_list));
        parsinglistsize = ds_list_size(audio_list);
        for (i = 0; i < parsinglistsize; i++)
            {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(audio_list,i));
            }
        }
    }
    
buffer_write(save_buffer,buffer_u32,ds_list_size(marker_list));
parsinglistsize = ds_list_size(marker_list);
for (i = 0; i < parsinglistsize; i++)
    {
    buffer_write(save_buffer,buffer_u32,ds_list_find_value(marker_list,i));
    }
    
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
buffer_save(save_buffer,file_loc);
show_message_async("LasershowGen project saved to "+string(file_loc));

buffer_delete(save_buffer);