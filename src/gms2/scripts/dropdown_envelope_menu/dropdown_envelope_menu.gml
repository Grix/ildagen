ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);
with (ddobj)
    {
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Toggle minimize");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_hide);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Toggle mute")
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_env_disable);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Change type");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dropdown_envelope_type);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Clear data");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_clear);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Delete envelope");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_delete);
    ds_list_add(hl_list,1);
    }
