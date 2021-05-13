if (room != rm_options)
    exit;
	
if (window_get_height() != (view_hport[3]+view_hport[0]) || window_get_width() != view_wport[3])
&& !(window_get_height() == 0 || window_get_width() == 0)
|| controller.forceresize
{
	//if (window_get_height() < controller.default_window_h || window_get_width() < controller.default_window_w)
	//	window_set_size(controller.default_window_w, controller.default_window_h);
	
	if (controller.dpi_scaling == 0 || controller.dpi_scaling == -1)
		controller.dpi_multiplier = min( ceil(window_get_height()/(735*2.05)), ceil(window_get_width()/(1350*2)) );
	
	log("Resized window");
	controller.forceresize = false;
	
	view_hport[3] = 23*controller.dpi_multiplier;
	view_hport[1] = 705*controller.dpi_multiplier;
	view_wport[1] = 1300*controller.dpi_multiplier;
	view_hport[0] = window_get_height()-view_hport[3];
	view_wport[0] = window_get_width();
	view_wport[3] = window_get_width();
	view_yport[3] = 0;
	view_yport[1] = view_hport[3];
	view_yport[0] = view_hport[3];
	camera_set_view_size(view_camera[0], view_wport[0]/controller.dpi_multiplier, view_hport[0]/controller.dpi_multiplier);
	camera_set_view_size(view_camera[3], view_wport[3]/controller.dpi_multiplier, view_hport[3]/controller.dpi_multiplier);
	camera_set_view_size(view_camera[1], view_wport[1]/controller.dpi_multiplier, view_hport[1]/controller.dpi_multiplier);
	
	free_scalable_surfaces();
}

if (keyboard_check_pressed(vk_tab))
    room_goto(rm_ilda);
    

if (keyboard_check_pressed(vk_escape))
{
    if (controller.laseron)
    {
        controller.laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(controller.dac);
    }
}

