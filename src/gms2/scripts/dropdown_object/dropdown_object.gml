function dropdown_object() {
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 6;
	    event_user(1);
	    ds_list_add(desc_list,"Cut ("+get_ctrl_string()+"+X)");
	    ds_list_add(desc_list,"Copy ("+get_ctrl_string()+"+C)");
	    ds_list_add(desc_list,"Delete ("+get_delete_string()+")");
	    ds_list_add(desc_list,"Reapply Properties (Enter)");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,cut_object);
	    ds_list_add(scr_list,copy_object);
	    ds_list_add(scr_list,delete_object);
	    ds_list_add(scr_list,reapply_properties);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(desc_list,"Deselect all objects");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,deselect_object);
	    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
		ds_list_add(desc_list,"Merge selected objects");
		ds_list_add(sep_list,0);
		ds_list_add(scr_list,merge_elements);
		ds_list_add(hl_list,(ds_list_size(controller.semaster_list) > 1));
	}



}
