//paste timeline object
if (!ds_exists(copy_list,ds_type_list)) or (!ds_list_empty(seqcontrol.somaster_list)) or (ds_list_empty(seqcontrol.layer_list)) or (seqcontrol.selectedlayer = -1)
    exit;
    
for (i = 0; i < ds_list_size(copy_list); i++)
    {
    copy_list_new = ds_list_create();
    ds_list_copy(copy_list_new,ds_list_find_value(copy_list,i)); 
    copy_buffer_new = buffer_create(1,buffer_grow,1);
    buffer_copy(ds_list_find_value(copy_buffer,i),
                0,
                buffer_get_size(ds_list_find_value(copy_buffer,i)),
                copy_buffer_new,
                0);
    
    layerlisttemp = ds_list_find_value(layer_list,selectedlayer);
    new_objectlist = ds_list_create();
    ds_list_add(new_objectlist,selectedx);
    ds_list_add(new_objectlist,copy_buffer_new);
    ds_list_add(new_objectlist,copy_list_new);
    ds_list_add(layerlisttemp,new_objectlist);
    
    undolisttemp = ds_list_create();
    ds_list_add(undolisttemp,layerlisttemp);
    ds_list_add(undolisttemp,new_objectlist);
    ds_list_add(undo_list,"c"+string(undolisttemp));
    
    if (i == 0)
        selectedx += (ds_list_find_value(copy_list_new,0)+1);
    }
    
frame_surf_refresh = 1;
