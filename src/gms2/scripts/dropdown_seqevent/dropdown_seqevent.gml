function dropdown_seqevent() {
	
	if (ds_list_empty(seqcontrol.selected_event_master_list))
		return;
	
	ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 3;
		
		var t_event = ds_list_find_value(seqcontrol.selected_event_master_list, 0);
		var t_multiple_selected = ds_list_size(seqcontrol.selected_event_master_list) > 1;
		
		if (t_event[| 1] == 0) // DMX value change
		{
			num += 3;
			ds_list_add(desc_list,"Set DMX value (" + (t_multiple_selected ? "NB: Multiple selected" : ("currently " + string(t_event[| 5]))) + ")");
		    ds_list_add(sep_list,0);
		    ds_list_add(scr_list,reverse_timelineobject);
		    ds_list_add(hl_list,1);
			ds_list_add(desc_list,"Set DMX channel (" + (t_multiple_selected ? "NB: Multiple selected" : ("currently " + string(t_event[| 4]))) + ")");
		    ds_list_add(sep_list,0);
		    ds_list_add(scr_list,reverse_timelineobject);
		    ds_list_add(hl_list,1);
			ds_list_add(desc_list,"Set DMX universe (" + (t_multiple_selected ? "NB: Multiple selected" : ("currently " + string(t_event[| 3]))) + ")");
		    ds_list_add(sep_list,0);
		    ds_list_add(scr_list,reverse_timelineobject);
		    ds_list_add(hl_list,1);
		}
		
	    ds_list_add(desc_list,"Cut ("+get_ctrl_string()+"+X)");
	    ds_list_add(desc_list,"Copy ("+get_ctrl_string()+"+C)");
	    ds_list_add(desc_list,"Delete (Del)");
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
	    ds_list_add(scr_list,seq_cut_object);
	    ds_list_add(scr_list,seq_copy_object);
	    ds_list_add(scr_list,seq_delete_object);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
		
		
	    event_user(1);
		
	}



}
