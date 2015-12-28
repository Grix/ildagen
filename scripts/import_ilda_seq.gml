with(controller)
    {
    if (read_ilda_init(argument0) == 0) exit;
    
    ildlistsize = ds_list_size(ild_list);
    framelistsize = ds_list_size(frame_list);
    
    frames_toseq_importedilda();
    
    ds_list_destroy(ild_list);
    
    scope_end = maxframes-1;
    refresh_miniaudio_flag = 1;
    
    }
return 1;
