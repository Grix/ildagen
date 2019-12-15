if (room == rm_loading)
{
    if (global.loading_importildalive == 1)
    {
        if (global.loading_current < global.loading_end)
            read_ilda_work();
        else
            import_ildalive_end();
    }
	else if (global.loading_saveliveproject == 1)
    {
        save_live_project_work();
    }
	else if (global.loading_loadliveproject == 1)
    {
        load_live_project_work();
    }
}

if (room != rm_live) exit;

if (window_get_height() != (view_hport[3]+view_hport[4]+view_hport[1]) || window_get_width() != view_wport[3])
&& !(window_get_height() == 0 || window_get_width() == 0)
|| controller.forceresize
{
	//if (window_get_height() < controller.default_window_h || window_get_width() < controller.default_window_w)
	//	window_set_size(controller.default_window_w, controller.default_window_h);
	
	log("Resized window");
	controller.forceresize = false;
	
	view_hport[0] = 706;
	view_wport[0] = 316;
	view_wport[1] = max(window_get_width()-view_wport[0], 1);
	view_wport[4] = view_wport[1];
	view_hport[4] = (window_get_height()-view_hport[3])*0.2*(power(window_get_height()/706, 0.8));
	view_hport[1] = window_get_height()-view_hport[3]-view_hport[4];
	view_yport[1] = view_hport[4]+view_hport[3];
	view_xport[0] = view_wport[1];
	view_wport[6] = view_wport[0];
	view_hport[6] = max(window_get_height()-view_hport[3]-view_hport[0], 1);
	view_xport[6] = view_xport[0];
	view_yport[6] = view_hport[3]+view_hport[0];
	view_wport[3] = window_get_width();
	view_yport[3] = 0;
	camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	camera_set_view_size(view_camera[3], view_wport[3], view_hport[3]);
	camera_set_view_size(view_camera[4], view_wport[4], view_hport[4]);
	camera_set_view_size(view_camera[1], view_wport[1], view_hport[1]);
	camera_set_view_size(view_camera[6], view_wport[6], view_hport[6]);
	camera_set_view_pos(view_camera[6], 987, camera_get_view_y(view_camera[0])+view_yport[6]-view_hport[3]);
	tlw = view_wport[1];
	
	free_scalable_surfaces();
}

if (instance_exists(obj_dropdown))
    exit;
    
if (keyboard_check(vk_control))
{
    //CTRL+*
    /*if (keyboard_check_pressed(ord("C")))
    {
        if (!ds_list_empty(somaster_list))
        {
            //COPY
            seq_copy_object();
        }
    }
    else if (keyboard_check_pressed(ord("X")))
    {
        if (!ds_list_empty(somaster_list))
        {
            //COPY
            seq_cut_object();
        }
    }
    else if (keyboard_check_pressed(ord("V")))
    {
        if (selectedlayer >= 0) and (selectedx >= 0)
        {
            //COPY
            seq_paste_object();
        }
    }
    */
	if (keyboard_check_pressed(ord("Z")))
    {
        undo_live();
    }
}

else if (keyboard_check_pressed(vk_escape))
{
    if (controller.laseron)
    {
        controller.laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(controller.dac);
    }
}
    
else if (keyboard_check_pressed(vk_space))
{
    playing = !playing;
}
    

else if (keyboard_check_pressed(vk_tab))
{
    playing = 0;
	room_goto(rm_ilda);
}
    
else if (keyboard_check_pressed(ord("P")))
{
    viewmode++;
    if (viewmode > 2)
        viewmode = 0;
    frame_surf_refresh = 1;
}

else if (keyboard_check_pressed(vk_delete))
{
    if (selectedfile != -1)
		live_delete_object();
}

else if (keyboard_check_pressed(vk_backspace))
{
	frame_surf_refresh = 1;
	if (surface_exists(browser_surf))
		surface_free(browser_surf);
	browser_surf = -1;
	frame = 0;
    playing = 0;
	selectedfile = -1;
}

else
{
	for (i = 0; i < ds_list_size(filelist); i++)
	{
		if (ds_list_find_value(filelist[| i], 3) == -1)
		{
			if (keyboard_check_pressed(vk_anykey))
			{
				if (keyboard_check_pressed(ord(string_upper(string_char_at(keyboard_string,string_length(keyboard_string))))))
				{
					ds_list_set(filelist[| i], 3, ord(string_upper(string_char_at(keyboard_string,string_length(keyboard_string)))));
				}
				else
				{
					ds_list_set(filelist[| i], 3, 0);
				}
				if (surface_exists(browser_surf))
					surface_free(browser_surf);
				browser_surf = -1;
			}
		}
		else if (ds_list_find_value(filelist[| i], 3) > 0)
		{
			if (keyboard_check_pressed(ds_list_find_value(filelist[| i], 3)))
			{
				if (ds_list_find_value(filelist[| i], 0))
				{
					// stop
					ds_list_set(filelist[| i], 0, false);
				}
				else
				{
					// play
					if (stop_at_play)
					{
						for (j = 0; j < ds_list_size(filelist); j++)
						{
							ds_list_set(filelist[| j], 0, false);
						}
					}
					
					playing = 1;
					ds_list_set(filelist[| i], 0, true);
						
					if (ds_list_find_value(filelist[| i], 6) == 0) // if resume instead of restart
						ds_list_set(ds_list_find_value(filelist[| i], 2), 0, 0);
				}
				frame_surf_refresh = 1;
				if (surface_exists(browser_surf))
					surface_free(browser_surf);
				browser_surf = -1;
			}
		}
	}
}
    
handle_mousecontrol_live();



