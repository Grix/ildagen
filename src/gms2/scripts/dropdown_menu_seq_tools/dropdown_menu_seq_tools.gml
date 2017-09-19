ddobj = instance_create_layer(seqcontrol.menu_width_start[3],0,"foreground",oDropDown);
with (ddobj)
{
    num = 4;
    event_user(1);
    ds_list_add(desc_list,"Insert timeline marker");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_addmarker);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Clear timeline markers");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_clearmarker);
    ds_list_add(hl_list,!ds_list_empty(seqcontrol.marker_list));
    ds_list_add(desc_list,"Load audio");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,load_audio);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Remove audio");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,remove_audio);
    ds_list_add(hl_list,1);
}
