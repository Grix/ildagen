ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);
with (ddobj)
    {
    num = 4;
    event_user(1);
    ds_list_add(desc_list,"Optimized ILDA output");
    ds_list_add(desc_list,"Raw ILDA output");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_export_opt);
    ds_list_add(scr_list,dd_export_min);
    ds_list_add(hl_list,controller.exp_optimize);
    ds_list_add(hl_list,!controller.exp_optimize);
    ds_list_add(desc_list,"Format 5 ILDA output");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_export_format5);
    ds_list_add(hl_list,(controller.exp_format == 5));
    ds_list_add(desc_list,"Legacy Format 0 ILDA output");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_export_format0);
    ds_list_add(hl_list,(controller.exp_format == 0));
    }
    
