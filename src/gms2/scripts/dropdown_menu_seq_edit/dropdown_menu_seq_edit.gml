function dropdown_menu_seq_edit() {
	ddobj = instance_create_layer(seqcontrol.menu_width_start[1]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 10;
	    ds_list_add(desc_list,"Undo ("+get_ctrl_string()+"+Z)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,undo_seq);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.undo_list));
		ds_list_add(desc_list,"Redo ("+get_ctrl_string()+"+Y)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,redo_seq);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.redo_list));
	    ds_list_add(desc_list,"Send selected frames to editor mode");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_fromseq);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
	    ds_list_add(desc_list,"Cut ("+get_ctrl_string()+"+X)");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,seq_cut_object);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
	    ds_list_add(desc_list,"Copy ("+get_ctrl_string()+"+C");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,seq_copy_object);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
	    ds_list_add(desc_list,"Paste ("+get_ctrl_string()+"+V)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,seq_paste_object);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.copy_list));
	    ds_list_add(desc_list,"Delete ("+get_delete_string()+")");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,seq_delete_object);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
	    ds_list_add(desc_list,"Change duration");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_object_duration);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));  
	    ds_list_add(desc_list,"Split object (S)");
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,split_timelineobject);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
	    ds_list_add(desc_list,"Deselect");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_deselect);
	    ds_list_add(hl_list,ds_list_size(seqcontrol.somaster_list));
	    event_user(1);
	}



}
