ddobj = instance_create_layer(mouse_x,mouse_y,"foreground",obj_dropdown);
with (ddobj)
    {
    num = 3;
    event_user(1);
    ds_list_add(desc_list,"Paste");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,paste_object);
    ds_list_add(hl_list,controller.copy_list != -1);
    ds_list_add(desc_list,"Select all objects");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_selectall);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Deselect all objects");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,deselect_object);
    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));

    }
