ddobj = instance_create(controller.menu_width_start[0],1,oDropDown);
with (ddobj)
    {
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Save LasershowGen frames file");
    ds_list_add(desc_list,"Load LasershowGen frames file");
    ds_list_add(desc_list,"Export ILDA file");
    ds_list_add(desc_list,"Import ILDA file");
    ds_list_add(desc_list,"Send frames to timeline mode");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,save_frames);
    ds_list_add(scr_list,update_check_verbose);
    ds_list_add(scr_list,verify_serial);
    ds_list_add(scr_list,update_check_verbose);
    ds_list_add(scr_list,verify_serial);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }
