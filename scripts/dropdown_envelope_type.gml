ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 2;
    event_user(1);
    ds_list_add(desc_list,"X (Horizontal displacement)");
    ds_list_add(desc_list,"Y (Vertical displacement)");
    ds_list_add(desc_list,"Size");
    ds_list_add(desc_list,"Intensity (Alpha)");
    ds_list_add(desc_list,"Color Hue");
    ds_list_add(desc_list,"Red Color Channel");
    ds_list_add(desc_list,"Green Color Channel");
    ds_list_add(desc_list,"Blue Color Channel");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dropdown_envelope_type);
    ds_list_add(scr_list,layer_delete);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }
