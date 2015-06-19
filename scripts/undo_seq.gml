with (seqcontrol)
    {
    if (ds_list_size(undo_list) == 0)
        exit;
        
    undo = ds_list_find_value(undo_list,ds_list_size(undo_list)-1);
    ds_list_delete(undo_list,ds_list_size(undo_list)-1);
    
    if (string_char_at(undo,0) == 'd')
        {
        //undo delete object
        layertemp = real(string_digits(undo));
        infolisttemp = real(string_digits(ds_list_find_value(undo_list,ds_list_size(undo_list)-1)));
        ds_list_delete(undo_list,ds_list_size(undo_list)-1);
        frametime = real(string_digits(ds_list_find_value(undo_list,ds_list_size(undo_list)-1)));
        ds_list_delete(undo_list,ds_list_size(undo_list)-1);
        
        if (ds_list_size(layer_list)-1 > layertemp)
            {
            repeat (layertemp - ds_list_size(layer_list)-1) 
                {
                newlayer = ds_list_create();
                ds_list_add(layer_list,newlayer);
                }
            }
        layerlisttemp = ds_list_find_value(layer_list,layertemp);
        ds_list_add(layerlisttemp,frametime);
        ds_list_add(layerlisttemp,-1);
        ds_list_add(layerlisttemp,infolisttemp);
        }
    else if (string_char_at(undo,0) == 'r')
        {
        //undo resize object
        undolisttemp = real(string_digits(undo));
        ds_list_replace(ds_list_find_value(undolisttemp,0),0,ds_list_find_value(undolisttemp,1));
        ds_list_destroy(undolisttemp);
        }
    else if (string_char_at(undo,0) == 'm')
        {
        //undo move object
        undolisttemp = real(string_digits(undo));
        var originallayer = ds_list_find_value(undolisttemp,0);
        infolisttemp = ds_list_find_value(undolisttemp,1);
        var originalx = ds_list_find_value(undolisttemp,2);
        var finallayer = ds_list_find_value(undolisttemp,3);
        var loopsafety = 1000;
        do 
            {
            finalx = ds_list_find_index(finallayer,infolisttemp)-2;
            loopsafety--;
            }
        until ((finalx mod 3) == 0) or !loopsafety
        ds_list_add(originallayer,originalx);
        ds_list_add(originallayer,ds_list_find_value(finallayer,finalx+1));
        ds_list_add(originallayer,ds_list_find_value(finallayer,finalx+2));
        repeat (3)
            ds_list_delete(finallayer,finalx);
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
