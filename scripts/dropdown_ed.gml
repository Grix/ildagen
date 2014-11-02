
ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 4;
    event_user(1);
    ds_list_add(desc_list,"Bright dots");
    ds_list_add(desc_list,"Medium dots");
    ds_list_add(desc_list,"Weak dots");
    ds_list_add(desc_list,"Custom brightness ..");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ed_high);
    ds_list_add(scr_list,dd_ed_med);
    ds_list_add(scr_list,dd_ed_low);
    ds_list_add(scr_list,dd_ed_custom);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    if (controller.dotmultiply == 10) highlighted = 0;
    else if (controller.dotmultiply == 4) highlighted = 1;
    else if (controller.dotmultiply == 1) highlighted = 2;
    else highlighted = 3;
    ds_list_replace(hl_list,highlighted,1);
    }
    
