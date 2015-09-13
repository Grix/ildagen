with (seqcontrol)
    {
    if ds_list_empty(seqcontrol.somaster_list) exit;
    
    /*infolisttomove = ds_list_find_value(abs(selectedx),2);
    object_length = ds_list_find_value(infolisttomove,0);
                                   
    undolisttemp = ds_list_create();
    ds_list_add(undolisttemp,infolisttomove);
    ds_list_add(undolisttemp,object_length);*/
    
    seq_dialog_num("objectduration","Enter the number of frames these object(s) should last on the timeline. If the number of frames is larger than the object itself, it will loop.",1);
    }