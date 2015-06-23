//paste timeline object
if (!ds_exists(copy_list,ds_type_list))
    exit;

copy_list_new = ds_list_create();
ds_list_copy(copy_list_new,copy_list); 
copy_buffer_new = buffer_create(1,buffer_grow,1);
buffer_copy(copy_buffer,
            0,
            buffer_get_size(copy_buffer),
            copy_buffer_new,
            0);

layerlisttemp = ds_list_find_value(layer_list,selectedlayer);
ds_list_add(layerlisttemp,selectedx);
ds_list_add(layerlisttemp,copy_buffer_new);
ds_list_add(layerlisttemp,copy_list_new);

frame_surf_refresh = 1;

undolisttemp = ds_list_create();
ds_list_add(undolisttemp,layerlisttemp);
ds_list_add(undolisttemp,copy_list_new);
ds_list_add(undo_list,"c"+string(undolisttemp));

selectedx += ds_list_find_value(copy_list_new,2);
