//paste timeline object
if (!ds_exists(copy_list,ds_type_list)) or (!ds_list_empty(seqcontrol.somaster_list)) or (ds_list_empty(seqcontrol.layer_list)) or (seqcontrol.selectedlayer = -1)
    exit;
    
if (ds_list_size(copy_list) != 0)
{
    ds_list_clear(somaster_list);
    
    for (i = 0; i < ds_list_size(copy_list); i++)
    {
        copy_list_new = ds_list_create();
        ds_list_copy(copy_list_new,ds_list_find_value(copy_list,i)); 
        if (i == 0)
        {
            pos_ref = ds_list_find_value(copy_list_new,ds_list_size(copy_list_new)-1);
            layer_ref = ds_list_find_value(copy_list_new,ds_list_size(copy_list_new)-2);
        }
        postemp = ds_list_find_value(copy_list_new,ds_list_size(copy_list_new)-1);
        ds_list_delete(copy_list_new,ds_list_size(copy_list_new)-1);
        layertemp = ds_list_find_value(copy_list_new,ds_list_size(copy_list_new)-1);
        ds_list_delete(copy_list_new,ds_list_size(copy_list_new)-1);
        
        copy_buffer_new = buffer_create(1,buffer_grow,1);
        buffer_copy(ds_list_find_value(copy_buffer,i),
                    0,
                    buffer_get_size(ds_list_find_value(copy_buffer,i)),
                    copy_buffer_new,
                    0);
        
        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,clamp(selectedlayer+layertemp-layer_ref,0,ds_list_size(layer_list)-1)), 1);
        new_objectlist = ds_list_create();
        new_pos = selectedx+postemp-pos_ref;
        if (new_pos < 0) new_pos = 0;
        ds_list_add(new_objectlist,new_pos);
        ds_list_add(new_objectlist,copy_buffer_new);
        ds_list_add(new_objectlist,copy_list_new);
        ds_list_add(layerlisttemp,new_objectlist);
        
        undolisttemp = ds_list_create();
        ds_list_add(undolisttemp,layerlisttemp);
        ds_list_add(undolisttemp,new_objectlist);
        ds_list_add(undo_list,"c"+string(undolisttemp));
        
        //ds_list_add(somaster_list,new_objectlist);
        
        if (i == 0)
            selectedxbump = (ds_list_find_value(copy_list_new,0)+1);
    }
        
    selectedx += selectedxbump;
    frame_surf_refresh = 1;
}
