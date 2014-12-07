ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 3;
    event_user(1);
    ds_list_add(desc_list,"Set start frame");
    ds_list_add(desc_list,"Set end frame");
    ds_list_add(desc_list,"Reset to cover all frames");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_scope_start);
    ds_list_add(scr_list,dd_scope_end);
    ds_list_add(scr_list,dd_scope_reset);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }
    