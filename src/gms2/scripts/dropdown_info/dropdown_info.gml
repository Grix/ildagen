ddobj = instance_create_layer(mouse_x,mouse_y,"foreground",oDropDown);
with (ddobj)
    {
    num = 2;
    event_user(1);
    controller.update_verbose = 1;
    ds_list_add(desc_list,"Enter registration code");
    ds_list_add(desc_list,"Check for updates");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,verify_serial);
    ds_list_add(scr_list,update_check_verbose);
    ds_list_add(hl_list,verify_serial(false));
    ds_list_add(hl_list,1);
    }
