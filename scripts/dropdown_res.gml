
ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Auto");
    ds_list_add(desc_list,"High Detail");
    ds_list_add(desc_list,"Medium Detail");
    ds_list_add(desc_list,"Low Detail");
    ds_list_add(desc_list,"Custom ..");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_res_auto);
    ds_list_add(scr_list,dd_res_high);
    ds_list_add(scr_list,dd_res_med);
    ds_list_add(scr_list,dd_res_low);
    ds_list_add(scr_list,dd_res_custom);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    if (is_string(controller.resolution)) highlighted = 0;
    else if (controller.resolution == 300) highlighted = 1;
    else if (controller.resolution == 700) highlighted = 2;
    else if (controller.resolution == 3000) highlighted = 3;
    else highlighted = 4;
    ds_list_replace(hl_list,highlighted,1);
    }
    