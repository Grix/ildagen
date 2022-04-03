function dropdown_menu_ilda_edit() {
	ddobj = instance_create_layer(controller.menu_width_start[1]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 12;
	    ds_list_add(desc_list,"Undo ("+get_ctrl_string()+"+Z)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,undo_ilda);
	    ds_list_add(hl_list,!ds_list_empty(controller.undo_list));
		ds_list_add(desc_list,"Redo ("+get_ctrl_string()+"+Y)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,redo_ilda);
	    ds_list_add(hl_list,!ds_list_empty(controller.redo_list));
	    ds_list_add(desc_list,"Cut ("+get_ctrl_string()+"+X)");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,cut_object);
	    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
	    ds_list_add(desc_list,"Copy ("+get_ctrl_string()+"+C");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,copy_object);
	    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
	    ds_list_add(desc_list,"Paste ("+get_ctrl_string()+"+V)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,paste_object);
	    ds_list_add(hl_list,(controller.copy_list != -1));
	    ds_list_add(desc_list,"Delete (Del)");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,delete_object);
	    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
	    ds_list_add(desc_list,"Select all ("+get_ctrl_string()+"+A)");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_ilda_selectall);
	    ds_list_add(hl_list,!ds_list_empty(controller.el_list));
	    ds_list_add(desc_list,"Deselect all");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,deselect_object);
	    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
		ds_list_add(desc_list,"Change number of frames (pad)");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_ilda_maxframes);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Change number of frames (stretch)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,dd_ilda_maxframes_stretch);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Reverse animation");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,ilda_reverse);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Merge selected objects");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,merge_elements);
	    ds_list_add(hl_list,!ds_list_empty(controller.semaster_list));
	    event_user(1);
	}



}
