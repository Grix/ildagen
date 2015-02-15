//loads project igp file
file_loc = argument0;
if (file_loc == "") or is_undefined(file_loc)
    exit;
    
clear_project();

if (fastload)
    {
    load_buffer = buffer_load(file_loc);
    }
else
    load_buffer = buffer_load_alt(file_loc);
    
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
    
maxlayers = buffer_read(load_buffer,buffer_s32);
//show_debug_message("maxlayers: "+string(maxlayers))
for (j = 0; j < maxlayers;j++)
    {
    layer = ds_list_create();
    ds_list_add(layer_list,layer);
    
    numofobjects = buffer_read(load_buffer,buffer_s32);
    show_debug_message("numofobj: "+string(numofobjects))
    for (i = 0; i < numofobjects;i++)
        {
        objectlist = ds_list_create();
        ds_list_add(objectlist,buffer_read(load_buffer,buffer_s32));
        
        
        objectbuffersize = buffer_read(load_buffer,buffer_s32);
        objectbuffer = buffer_create(objectbuffersize,buffer_fixed,1);
        ds_list_add(objectlist,objectbuffer);
        buffer_copy(load_buffer,buffer_tell(load_buffer),objectbuffersize,objectbuffer,0);
        buffer_seek(load_buffer,buffer_seek_relative,objectbuffersize);
        //show_debug_message("buffer_tell: "+string(buffer_tell(load_buffer)))
        
        objectinfolist = ds_list_create();
        ds_list_add(objectlist,objectinfolist);
        ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_s32));
        ds_list_add(objectinfolist,-1);
        ds_list_add(objectinfolist,buffer_read(load_buffer,buffer_s32));
        show_debug_message("maxframes: "+string(ds_list_find_value(objectinfolist,2)));
        show_debug_message("length: "+string(ds_list_find_value(objectinfolist,0)));
        ds_list_add(layer,objectlist);
        
        }
    //show_debug_message("layersize: "+string(ds_list_size(layer)));
    }

//show_debug_message("songload: "+string(songload));
//show_debug_message("parsingload: "+string(parsingaudioload));

