function dropdown_normalize_path() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 1;
	    ds_list_add(desc_list,"Normalize drawing path");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_normalize_path_toggle);
	    ds_list_add(hl_list,controller.editing_path_normalized);
		
	    event_user(1);
	}

}
