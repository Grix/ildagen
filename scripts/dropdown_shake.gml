ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 4;
    event_user(1);
    ds_list_add(desc_list,"Strong shaking");
    ds_list_add(desc_list,"Medium shaking");
    ds_list_add(desc_list,"Weak shaking");
    ds_list_add(desc_list,"Custom strength ..");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_shake_high);
    ds_list_add(scr_list,dd_shake_med);
    ds_list_add(scr_list,dd_shake_low);
    ds_list_add(scr_list,dd_shake_custom);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    ds_list_add(hl_list,0);
    if (controller.shaking_sdev == 10) highlighted = 0;
    else if (controller.shaking_sdev == 5) highlighted = 1;
    else if (controller.shaking_sdev == 2) highlighted = 2;
    else highlighted = 3;
    ds_list_replace(hl_list,highlighted,1);
    }
    