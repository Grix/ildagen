//copy timeline object
if (ds_exists(copy_list,ds_type_list))
    {
    if (surface_exists(ds_list_find_value(copy_list,1)))
        surface_free(ds_list_find_value(copy_list,1));
    ds_list_destroy(copy_list);
    //if buffer exists
        buffer_delete(copy_buffer);
    }

layerlisttemp = ds_list_find_value(layer_list,selectedlayer);
copy_list = ds_list_create();
ds_list_copy(copy_list,ds_list_find_value(abs(selectedx),2)); 
copy_buffer = buffer_create(1,buffer_grow,1);
buffer_copy(ds_list_find_value(abs(selectedx),1),
            0,
            buffer_get_size(ds_list_find_value(abs(selectedx),1)),
            copy_buffer,
            0);

selectedx = ds_list_find_value(abs(selectedx),0)+ds_list_find_value(ds_list_find_value(abs(selectedx),2),0);
