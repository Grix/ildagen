ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
with (ddobj)
{
    num = 6;
    ds_list_add(desc_list,"Paste");
    ds_list_add(desc_list,"Import object from editor");
	ds_list_add(desc_list,"Mute/unmute layer");
    ds_list_add(desc_list,"Add envelope");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
	ds_list_add(sep_list,1);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,seq_paste_object);
    ds_list_add(scr_list,seq_fromilda);
	ds_list_add(scr_list,layer_mute);
    ds_list_add(scr_list,dd_seq_add_envelope);
    ds_list_add(hl_list,ds_list_size(seqcontrol.copy_list));
    ds_list_add(hl_list,1);
	ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Rename layer");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_rename);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Delete layer");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,layer_delete);
    ds_list_add(hl_list,1);
    event_user(1);
}
