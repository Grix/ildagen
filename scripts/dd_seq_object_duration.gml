with (seqcontrol)
    {
    if !((seqcontrol.selectedlayer != -1) and (seqcontrol.selectedx < 0)) exit;
    
    infolisttomove = ds_list_find_value(abs(selectedx),2);
    object_length = ds_list_find_value(infolisttomove,0);
                                   
    undolisttemp = ds_list_create();
    ds_list_add(undolisttemp,infolisttomove);
    ds_list_add(undolisttemp,object_length);
    
    seq_dialog_num("objectduration","Enter the number of frames this object should last on the timeline",object_length+1);
    }