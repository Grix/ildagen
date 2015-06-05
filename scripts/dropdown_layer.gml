ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 4;
    event_user(1);
    ds_list_add(desc_list,"Paste");
    ds_list_add(desc_list,"Delete Layer");
    ds_list_add(desc_list,"Send Object From Editor");
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,seq_paste_object);
    ds_list_add(scr_list,layer_delete);
    ds_list_add(scr_list,seq_fromilda);
    ds_list_add(hl_list,(seqcontrol.copy_list != -1));
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }
