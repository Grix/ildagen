with (seqcontrol)
{
    if (ds_list_empty(undo_list))
        exit;
        
    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
    if (string_char_at(undo,0) == "c")
    {
        //undo create object (delete)
        undolisttemp = real(string_digits(undo));
        objectlist = ds_list_find_value(undolisttemp,0);
        if (!ds_exists(objectlist,ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            exit;
        }
        
        ds_list_clear(somaster_list);
        ds_list_add(somaster_list,objectlist);
        seq_delete_object_noundo();
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "s")
    {
        //undo split
        undolisttemp = real(string_digits(undo));
        objectlist = ds_list_find_value(undolisttemp,0);
        objectlist1 = ds_list_find_value(undolisttemp,1);
        objectlist2 = ds_list_find_value(undolisttemp,2);
        if (!ds_exists(objectlist1, ds_type_list) || !ds_exists(objectlist2, ds_type_list) || !ds_exists(objectlist, ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            ds_list_destroy(objectlist);
            exit;
        }
        
        for (j = 0; j < ds_list_size(layer_list); j++)
        {
            layertop = layer_list[| j];
            _layer = layertop[| 1];
            if (ds_list_find_index(_layer, objectlist1) != -1)
            {
                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist1));
                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist2));
                ds_list_destroy(objectlist1[| 2]);
                ds_list_destroy(objectlist2[| 2]);
                ds_list_destroy(objectlist1);
                ds_list_destroy(objectlist2);
                ds_list_add(_layer, objectlist);
            }
        }
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "d")
    {
        //undo delete object
        undolisttemp = real(string_digits(undo));
        objectlist = ds_list_find_value(undolisttemp,1);
        layerlisttemp = ds_list_find_value(undolisttemp,0);
        if (!ds_exists(layerlisttemp,ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            exit;
        }
            
        ds_list_add(layerlisttemp,objectlist);
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "r")
    {
        //undo resize object
        undolisttemp = real(string_digits(undo));
        infolist = undolisttemp[| 0];
        if (!ds_exists(infolist,ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            exit;
        }
        ds_list_replace(infolist,0,undolisttemp[| 1]);
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "m")
    {
        //undo move object
        undolisttemp = real(string_digits(undo));
        objectlist = ds_list_find_value(undolisttemp,0);
        layerlisttemp = ds_list_find_value(undolisttemp,1);
        frametime = ds_list_find_value(undolisttemp,2);
        if (!ds_exists(layerlisttemp,ds_type_list) || !ds_exists(objectlist,ds_type_list))
        {
            ds_list_destroy(undolisttemp);
            exit;
        }
            
        for (j = 0; j < ds_list_size(layer_list); j++)
        {
            layertop = layer_list[| j];
            _layer = layertop[| 1];
            if (ds_list_find_index(_layer, objectlist) != -1)
            {
                ds_list_delete(_layer, ds_list_find_index(_layer, objectlist));
                ds_list_replace(objectlist, 0, frametime); 
                ds_list_add(layerlisttemp, objectlist);
            }
        }
        ds_list_destroy(undolisttemp);
    }
    else if (string_char_at(undo,0) == "l")
    {
        //undo marker clear
        undolisttemp = real(string_digits(undo));
        ds_list_destroy(marker_list);
        marker_list = undolisttemp;
    }
    else if (string_char_at(undo,0) == "e")
    {
        //undo envelope data clear
        undolisttemp = real(string_digits(undo));
        if (!ds_exists(ds_list_find_value(undolisttemp,2),ds_type_list))
        {
            ds_list_destroy( ds_list_find_value(undolisttemp,0) );
            ds_list_destroy( ds_list_find_value(undolisttemp,1) );
        }
        else
        {
            var t_selectedenvelope = ds_list_find_value(undolisttemp,2);
            ds_list_destroy( ds_list_find_value(t_selectedenvelope,1) );
            ds_list_destroy( ds_list_find_value(t_selectedenvelope,2) );
            ds_list_replace( t_selectedenvelope,1,ds_list_find_value(undolisttemp,0) );
            ds_list_replace( t_selectedenvelope,2,ds_list_find_value(undolisttemp,1) );
        }
        ds_list_destroy(undolisttemp);
    }
    
    frame_surf_refresh = 1;
    selectedlayer = 0;
    selectedx = 0;
}
