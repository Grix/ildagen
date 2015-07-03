with (seqcontrol)
    {
    if (ds_list_size(undo_list) == 0)
        exit;
        
    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
    if (string_char_at(undo,0) == 'c')
        {
        //undo create object (delete)
        undolisttemp = real(string_digits(undo));
        finallayer = ds_list_find_value(undolisttemp,0);
        objectlist = ds_list_find_value(undolisttemp,1);
        if (!ds_exists(finallayer,ds_type_list)) or (!ds_exists(objectlist,ds_type_list))
            {
            ds_list_destroy(undolisttemp);
            exit;
            }
        selectedlayer = ds_list_find_index(layer_list,finallayer);
        
        selectedx = -objectlist;
        seq_delete_object_noundo();
        }
    if (string_char_at(undo,0) == 'd')
        {
        //undo delete object
        undolisttemp = real(string_digits(undo));
        objectlist = ds_list_find_value(undolisttemp,1);
        layerlisttemp = ds_list_find_value(undolisttemp,0);
        if (!ds_exists(layerlisttemp,ds_type_list))
            layerlisttemp = ds_list_find_value(layer_list,0);
            
        ds_list_add(layerlisttemp,objectlist);
        ds_list_destroy(undolisttemp);
        }
    else if (string_char_at(undo,0) == 'r')
        {
        //undo resize object
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(ds_list_find_value(undolisttemp,0),ds_type_list))
            {
            ds_list_destroy(undolisttemp);
            exit;
            }
        ds_list_replace(ds_list_find_value(undolisttemp,0),0,ds_list_find_value(undolisttemp,1));
        ds_list_destroy(undolisttemp);
        }
    else if (string_char_at(undo,0) == 'm')
        {
        //undo move object
        undolisttemp = real(string_digits(undo));
        originallayerlist = ds_list_find_value(undolisttemp,0);
        objectlist = ds_list_find_value(undolisttemp,1);
        originalx = ds_list_find_value(undolisttemp,2);
        finallayerlist = ds_list_find_value(undolisttemp,3);
        
        if (!ds_exists(originallayerlist,ds_type_list)) or (!ds_exists(finallayerlist,ds_type_list)) or (!ds_exists(objectlist,ds_type_list))
            {
            ds_list_destroy(undolisttemp);
            exit;
            }
        
        ds_list_replace(objectlist,0,originalx);
        ds_list_add(originallayerlist,objectlist);
        ds_list_delete(finallayerlist,ds_list_find_index(finallayerlist,objectlist));
        ds_list_destroy(undolisttemp);
        }
    else if (string_char_at(undo,0) == 'l')
        {
        //undo marker clear
        undolisttemp = real(string_digits(undo));
        ds_list_destroy(marker_list);
        marker_list = undolisttemp;
        }
    
    frame_surf_refresh = 1;
    selectedlayer = -1;
    selectedx = 1;
    }