function dropdown_dmx_interface_selector() {
	ddobj = instance_create_layer((obj_dmx_interface_selector.x + 80)*controller.dpi_multiplier,(obj_dmx_interface_selector.y)*controller.dpi_multiplier,"foreground",obj_dropdown);
	with (ddobj)
	{
		total_width = (290-80)*controller.dpi_multiplier;
		
	    num = dacwrapper_dmx_scan_interfaces();
		for (var t_i = 0; t_i < num; t_i++)
		{
		    ds_list_add(desc_list,dacwrapper_get_interface_ip(t_i));
		    ds_list_add(sep_list,1);
		    ds_list_add(scr_list,dd_select_dmx_interface);
		    ds_list_add(hl_list,1);
		}
	    event_user(1);
	}





}
