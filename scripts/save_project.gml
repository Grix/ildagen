//exports project into igp file

playing = 0;
if (song)
    FMODInstanceSetPaused(songinstance,1);
    
save_buffer = buffer_create(1,buffer_grow,1);

file_loc = get_save_filename_ext("*.igp","example.igp","","Select LasershowGen project file location");
if (file_loc == "")
    exit;
    
length = ceil(length);
    
buffer_write(save_buffer,buffer_u8,50); //version / ID
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
    }

if (song)
    {
    //todo: cache to speed up
    buffer_write(save_buffer,buffer_string,songfile_name);
    
    file_loc_song = songfile;
    FS_file_copy(file_loc_song,controller.FStemp+filename_name(file_loc_song));
    load_buffer_song = buffer_load("temp\"+filename_name(file_loc_song));
    songfile_size = buffer_get_size(load_buffer_song);
    buffer_write(save_buffer,buffer_u32,songfile_size);
    buffer_copy(load_buffer_song,0,songfile_size,save_buffer,buffer_tell(save_buffer));
    buffer_seek(save_buffer,buffer_seek_relative,songfile_size);
    //buffer_save(save_buffer,"testsave");
    //buffer_save(load_buffer_song,"testsong");
    /*for (i = 0; i < songfile_size; i++)
        {
        buffer_write(save_buffer,buffer_u8,FS_file_bin_read_byte(songfile_bin));
        }
    FS_file_bin_close(songfile_bin);
    */
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
if (file_exists("temp/"+filename_name(file_loc)))
    file_delete("temp/"+filename_name(file_loc));
if (FS_file_exists(file_loc))
    FS_file_delete(file_loc);
buffer_save(save_buffer,"temp/"+filename_name(file_loc));
FS_file_copy(controller.FStemp+filename_name(file_loc),file_loc);

if (FS_file_exists(file_loc))
    {
    binfile = FS_file_bin_open(file_loc,0);
    binfilesize = FS_file_bin_size(binfile);
    FS_file_bin_close(binfile);
    if (binfilesize == buffer_get_size(save_buffer))
        show_message_async("Project saved.");
    else
        {
        show_message_async("Problem saving file: Did not pass integrity test. May be corrupt, you might want to try again.");
        }
    }
else
    show_message_async("Could not save file. May not have access rights, try a different folder.");

buffer_delete(save_buffer);