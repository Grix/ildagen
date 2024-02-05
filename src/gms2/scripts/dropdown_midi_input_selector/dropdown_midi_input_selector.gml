function dropdown_midi_input_selector() {
	ddobj = instance_create_layer((obj_midi_input_selector.x + 90)*controller.dpi_multiplier,(obj_midi_input_selector.y)*controller.dpi_multiplier,"foreground",obj_dropdown);
	with (ddobj)
	{
		total_width = (350-90)*controller.dpi_multiplier;
		
	    num = rtmidi_probe_ins();
		for (var t_i = 0; t_i < num; t_i++)
		{
		    ds_list_add(desc_list,rtmidi_name_in(t_i));
		    ds_list_add(sep_list,1);
		    ds_list_add(scr_list,dd_select_midi_input);
		    ds_list_add(hl_list,1);
		}
	    event_user(1);
	}





}
