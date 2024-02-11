function dropdown_font_selector() {
	ddobj = instance_create_layer((obj_font_selector.x + 71)*controller.dpi_multiplier,(obj_font_selector.y)*controller.dpi_multiplier,"foreground",obj_dropdown);
	with (ddobj)
	{
		total_width = (300-71)*controller.dpi_multiplier;
		
	    num = 0;
		file = file_find_first("fonts/*.ild", 0);
		while (file != "")
		{
			var t_name = filename_change_ext(filename_name(file), "");
		    ds_list_add(desc_list, t_name);
		    ds_list_add(sep_list,1);
		    ds_list_add(scr_list,dd_select_font);
		    ds_list_add(hl_list,controller.selected_font_name != t_name);
			num++;
			file = file_find_next();
		}
	    event_user(1);
	}





}
