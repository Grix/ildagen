ddobj = instance_create(seqcontrol.menu_width_start[5],0,oDropDown);
with (ddobj)
    {
    num = 3;
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
    }
