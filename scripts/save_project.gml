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
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_u8,0);
repeat (40)
    buffer_write(save_buffer,buffer_u8,0);
buffer_write(save_buffer,buffer_s32,ds_list_size(layer_list)); //pos 50


for (i = 0; i < ds_list_size(layer_list); i++)
    {
    layer = ds_list_find_value(layer_list,i);
    buffer_write(save_buffer,buffer_u32,ds_list_size(layer)/3);
    for (j = 0; j < ds_list_size(layer); j+=3)
        {
        tempframe = ds_list_find_value(layer,j);
        tempbuffer = ds_list_find_value(layer,j+1);
        tempinfolist = ds_list_find_value(layer,j+2);
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
    songfile_bin = FS_file_bin_open(songfile,0);
    songfile_size = FS_file_bin_size(songfile_bin);
    buffer_write(save_buffer,buffer_u32,songfile_size);
    for (i = 0; i < songfile_size; i++)
        {
        buffer_write(save_buffer,buffer_u8,FS_file_bin_read_byte(songfile_bin));
        }
    FS_file_bin_close(songfile_bin);
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
    
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
FS_buffer_save(save_buffer,file_loc);

//todo: save_buffer() if possible to speed up
/*file = FS_file_bin_open(file_loc,1);
for (i = 0;i < buffer_get_size(save_buffer);i++)
    {
    FS_file_bin_write_byte(file,buffer_peek(save_buffer,i,buffer_u8));
    }
FS_file_bin_close(file);*/

if (FS_file_exists(file_loc))
    show_message_async("Project saved.");
else
    show_message_async("Could not save file. May not have access rights, try a different folder.");

buffer_delete(save_buffer);
