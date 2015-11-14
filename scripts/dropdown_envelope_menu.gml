ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 1;
    event_user(1);
    ds_list_add(desc_list,"Type");
    ds_list_add(desc_list,"Disable")
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dropdown_envelope_type);
    ds_list_add(scr_list,layer_delete);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }
