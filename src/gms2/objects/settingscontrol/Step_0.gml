if (room != rm_options)
    exit;
	
var t_windowwidth = window_get_width();
var t_windowheight = window_get_height();
	
if (t_windowheight != controller.previous_windows_h || t_windowwidth != controller.previous_windows_w)
&& !(t_windowheight == 0 || t_windowwidth == 0)
|| controller.forceresize
{
	if (t_windowwidth < 1000)
		t_windowwidth = 1000;
	if (t_windowheight < 600)
		t_windowheight = 600;
		
	//if (window_get_height() < controller.default_window_h || window_get_width() < controller.default_window_w)
	//	window_set_size(controller.default_window_w, controller.default_window_h);
	
	if (controller.dpi_scaling == 0 || controller.dpi_scaling == -1)
	{
		controller.dpi_multiplier = clamp(min( ceil(t_windowheight/(735*2.05)), ceil(t_windowwidth/(1350*2)) ),1,3);
		if (controller.dpi_multiplier == 1 && t_windowheight > 1450)
			controller.dpi_multiplier = 1.5;
	}
	
	log("Resized window");
	controller.forceresize = false;
	
	view_hport[3] = 23*controller.dpi_multiplier;
	view_hport[1] = 705*controller.dpi_multiplier;
	view_wport[1] = 1300*controller.dpi_multiplier;
	view_hport[0] = t_windowheight-view_hport[3];
	view_wport[0] = t_windowwidth;
	view_wport[3] = t_windowwidth;
	view_yport[3] = 0;
	view_yport[1] = view_hport[3];
	view_yport[0] = view_hport[3];
	camera_set_view_size(view_camera[0], view_wport[0]/controller.dpi_multiplier, view_hport[0]/controller.dpi_multiplier);
	camera_set_view_size(view_camera[3], view_wport[3]/controller.dpi_multiplier, view_hport[3]/controller.dpi_multiplier);
	camera_set_view_size(view_camera[1], view_wport[1]/controller.dpi_multiplier, view_hport[1]/controller.dpi_multiplier);
	
	free_scalable_surfaces();
	
	controller.previous_windows_h = t_windowheight;
	controller.previous_windows_w = t_windowwidth;
}

handle_midi_ilda();

if (keyboard_check_pressed(vk_tab))
{
	if (controller.tab_cycles_all == 1)
		room_goto(rm_ilda);
	else
		room_goto(controller.last_room_2);
}
    

if (keyboard_check_pressed(vk_escape))
{
    if (controller.laseron)
    {
        controller.laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(controller.dac);
    }
}

