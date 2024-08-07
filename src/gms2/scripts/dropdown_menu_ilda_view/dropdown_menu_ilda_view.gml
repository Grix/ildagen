function dropdown_menu_ilda_view() {
	if (room == rm_ilda || room == rm_seq )
		ddobj = instance_create_layer(controller.menu_width_start[3]*controller.dpi_multiplier,0,"foreground",obj_dropdown);
	else if (room == rm_live)
		ddobj = instance_create_layer(livecontrol.menu_width_start[2]*controller.dpi_multiplier,0,"foreground",obj_dropdown);

	with (ddobj)
	{
	    num = 6;
	    ds_list_add(desc_list,"Editor Mode" + ((room != rm_ilda) ? " (Tab)" : ""));
	    ds_list_add(desc_list,"Timeline Mode" + ((room == rm_ilda && controller.last_room == rm_seq) ? " (Tab)" : ""));
		ds_list_add(desc_list,"Grid View" + ((room == rm_ilda && controller.last_room == rm_live) ? " (Tab)" : ""));
	    ds_list_add(desc_list,"Toggle fullscreen (F11)");
	    ds_list_add(desc_list,"Reset window size (M)");
	    ds_list_add(desc_list,"Settings View");
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,0);
		ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(sep_list,0);
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_ilda_vieweditor);
	    ds_list_add(scr_list,dd_ilda_viewtimeline);
		ds_list_add(scr_list,dd_ilda_viewlive);
	    ds_list_add(scr_list,dd_ilda_togglefullscreen);
	    ds_list_add(scr_list,dd_ilda_resetwindow);
		ds_list_add(scr_list,dropdown_menu_ilda_settings);
	    ds_list_add(hl_list,(room != rm_ilda));
	    ds_list_add(hl_list,(room != rm_seq));
		ds_list_add(hl_list,(room != rm_live));
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,1);
	    ds_list_add(hl_list,(room != rm_options));
	    event_user(1);
	}



}
