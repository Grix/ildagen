dd_goto_options();


/*ddobj = instance_create_layer(controller.menu_width_start[5],0,"foreground",oDropDown);
with (ddobj)
    {
    num = 10;
    event_user(1);
    ds_list_add(desc_list,"Toggle update check at startup");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_ilda_toggleautoupdate);
    ds_list_add(hl_list,controller.updatecheckenabled);
    ds_list_add(desc_list,"Optimized ILDA output");
    ds_list_add(desc_list,"Raw ILDA output");
    ds_list_add(sep_list,1);
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
    ds_list_add(desc_list,"Set max travel distance");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_maxdist);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Set max dwell");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_ilda_maxdwell);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Set scanning speed");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_ilda_scanspeed);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Onion skinning settings...");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dropdown_onion);
    ds_list_add(hl_list,controller.onion);
    ds_list_add(desc_list,"Point density / Detail level...");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dropdown_res);
    ds_list_add(hl_list,1);
    }
