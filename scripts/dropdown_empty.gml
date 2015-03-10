ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 2;
    event_user(1);
    ds_list_add(desc_list,"Paste");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,paste_object);
    ds_list_add(hl_list,controller.copy_list != -1);
    ds_list_add(desc_list,"Deselect object");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,deselect_object);
    ds_list_add(hl_list,controller.selectedelement != -1);
    }