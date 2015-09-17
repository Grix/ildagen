ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 2;
    event_user(1);
    ds_list_add(desc_list,"Optimized ILDA output");
    ds_list_add(desc_list,"Raw ILDA output");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_export_opt);
    ds_list_add(scr_list,dd_export_min);
    ds_list_add(hl_list,controller.exp_optimize);
    ds_list_add(hl_list,!controller.exp_optimize);
    }
    
