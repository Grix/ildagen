ddobj = instance_create_layer(mouse_x,mouse_y,"foreground",oDropDown);
with (ddobj)
    {
    num = 2;
    ds_list_add(desc_list,"Delete blind zone");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,blindzone_delete);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Clear all blind zones");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,blindzone_clear);
    ds_list_add(hl_list,1);
    event_user(1);
    }
