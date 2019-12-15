ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);
with (ddobj)
{
    num = 6;
    event_user(1);
    ds_list_add(desc_list,"Delete (Del)");
    ds_list_add(desc_list,"Open in frame editor");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,live_delete_object);
    ds_list_add(scr_list,dd_live_toilda);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
	var label = "Toggle looping ";
	if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 4))
		label += "off";
	else
		label += "on";
	ds_list_add(desc_list,label);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,live_toggle_loop);
    ds_list_add(hl_list,1);
	var label = "Toggle exclusive ";
	if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 5))
		label += "off";
	else
		label += "on";
	ds_list_add(desc_list,label);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,live_toggle_exclusive);
    ds_list_add(hl_list,1);
	var label = "";
	if (ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 6))
		label += "Set resume at trigger";
	else
		label += "Set restart at trigger";
	ds_list_add(desc_list,label);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,live_toggle_resume);
    ds_list_add(hl_list,1);
	ds_list_add(desc_list,"Change keyboard shortcut...");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,live_change_shortcut);
    ds_list_add(hl_list,1);
}
