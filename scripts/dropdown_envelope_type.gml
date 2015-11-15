ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    var currenttype = ds_list_find_value(seqcontrol.selectedenvelope,0);
    num = 9;
    event_user(1);
    ds_list_add(desc_list,"X (Horizontal displacement)");
    ds_list_add(desc_list,"Y (Vertical displacement)");
    ds_list_add(desc_list,"Size");
    ds_list_add(desc_list,"Rotation (Absolute)");
    ds_list_add(desc_list,"Intensity (Alpha)");
    ds_list_add(desc_list,"Color Hue");
    ds_list_add(desc_list,"Red Color Channel");
    ds_list_add(desc_list,"Green Color Channel");
    ds_list_add(desc_list,"Blue Color Channel");
    repeat (9)
        ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_envtype_x);
    ds_list_add(scr_list,dd_seq_envtype_y);
    ds_list_add(scr_list,dd_seq_envtype_size);
    ds_list_add(scr_list,dd_seq_envtype_rotabs);
    ds_list_add(scr_list,dd_seq_envtype_a);
    ds_list_add(scr_list,dd_seq_envtype_hue);
    ds_list_add(scr_list,dd_seq_envtype_r);
    ds_list_add(scr_list,dd_seq_envtype_g);
    ds_list_add(scr_list,dd_seq_envtype_b);
    ds_list_add(hl_list,(currenttype == "x"));
    ds_list_add(hl_list,(currenttype == "y"));
    ds_list_add(hl_list,(currenttype == "size"));
    ds_list_add(hl_list,(currenttype == "rotabs"));
    ds_list_add(hl_list,(currenttype == "a"));
    ds_list_add(hl_list,(currenttype == "hue"));
    ds_list_add(hl_list,(currenttype == "r"));
    ds_list_add(hl_list,(currenttype == "g"));
    ds_list_add(hl_list,(currenttype == "b"));
    }
