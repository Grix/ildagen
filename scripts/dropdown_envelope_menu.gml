ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 3;
    event_user(1);
    ds_list_add(desc_list,"Type");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dropdown_envelope_type);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Clear");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_clear);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Disable")
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_disable);
    ds_list_add(hl_list,1);
    }
