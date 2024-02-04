function handle_mousecontrol_live() {
	//vertical scroll moving
	if (scroll_moving == 2)
	{
		var t_gridheight = max(1, camera_get_view_height(view_camera[1]));
	    scrollbary += (device_mouse_raw_y(0)-mouse_yprevious)/controller.dpi_multiplier*(ypos_perm+t_gridheight)/(t_gridheight-1);
	    if (scrollbary < 0) 
			scrollbary = 0;
	    if ((scrollbary) > ypos_perm+1) 
			scrollbary = ypos_perm+1;
    
	    mouse_yprevious = device_mouse_raw_y(0);
		log(mouse_yprevious, scrollbary);
    
	    if (mouse_check_button_released(mb_left))
	    {
	        scroll_moving = 0;
	    }
        
		timeline_surf_length = 0;
	    exit;
	}

	if (window_mouse_get_x() > tlw + scrollbarwidth*controller.dpi_multiplier) 
	or (window_mouse_get_y() < view_hport[3]+view_hport[4])
	or (controller.dialog_open)
	or (controller.menu_open)
	or (instance_exists(obj_dropdown))
	    exit;

	var t_width = max(1, camera_get_view_width(view_get_camera(1))-scrollbarwidth+1);
	var t_ystart = camera_get_view_y(view_get_camera(1))-scrollbary;
	var t_cells_per_row = ceil(t_width / target_width_per_cell);
	var t_cell_size = t_width / t_cells_per_row;

	var t_row;
	var t_column;


	highlightfile = -1;

	// scroll
	var t_gridheight = max(1, camera_get_view_height(view_camera[1]));
	var scrolly_y1 = round(t_ystart+scrollbary+(scrollbary*scrollbarw/t_gridheight));
	if (mouse_y == clamp(mouse_y,scrolly_y1, scrolly_y1+scrollbarw)) && (mouse_x == clamp(mouse_x,t_width,t_width+scrollbarwidth))
	{
	    controller.tooltip = "Drag to scroll the grid view.";
	    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
	    {
	        scroll_moving = 2;
	        mouse_yprevious = device_mouse_raw_y(0);;
	    }
		exit;
	}

	for (i = 0; i < ds_list_size(filelist); i++)
	{
		t_column = i mod t_cells_per_row;
		t_row = i div t_cells_per_row;
	
		if (t_ystart+t_row*t_cell_size < 0)
			continue;
	
		if (	mouse_x > t_column*t_cell_size+1		&& mouse_x < t_column*t_cell_size+1+t_cell_size
			&&	mouse_y > t_ystart+t_row*t_cell_size+1	&& mouse_y < t_ystart+t_row*t_cell_size+1+t_cell_size)
		{
			// mouse over an item cell
		
			highlightfile = i;
		
			objectlist = filelist[| i];
			var t_shortcut = "";
			if (objectlist[| 6] > 0)
			{
				t_shortcut += "keyboard key ";
				t_shortcut += chr(objectlist[| 6]);
			}
			if (objectlist[| 13] > 0)
			{
				if (string_length(t_shortcut) != 0)
					t_shortcut += " or ";
				t_shortcut += "MIDI key ";
				t_shortcut += midi_get_note_name(objectlist[| 13]);
			}
		
			controller.tooltip = "Click to select and play this file ("+t_shortcut+").\nDouble-click to open in editor mode.\nRight click for options, such as assigning keyboard or MIDI trigger key, and changing playback modes.";
		
			if (mouse_check_button_pressed(mb_left))
			{
				if (doubleclick && selectedfile == i)
				{
					//edit object
	                if (!controller.warning_disable)
						live_dialog_yesno("fromlive","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
					else
						with (livecontrol)
							frames_fromlive();
				}        
				else
				{
					selectedfile = i;
					if (ds_list_find_value(objectlist, 0))
					{
						// stop
						ds_list_set(objectlist, 0, false);
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
						ds_list_set(objectlist, 0, true);
					
						if (ds_list_find_value(objectlist, 9) == 0) // if restart instead of resume
							ds_list_set(objectlist, 2, 0);
						else 
						{
							if (ds_list_find_value(objectlist, 2) >= ds_list_find_value(objectlist, 4))
								ds_list_set(objectlist, 2, 0);
						}
					}
					frame_surf_refresh = 1;
				}
			}
			else if (mouse_check_button_pressed(mb_right))
			{
				selectedfile = i;
			
				dropdown_live_file();
			}
			
			if (mouse_check_button(mb_left))
			{
				if (objectlist[| 10] != 0)
					objectlist[| 10] = 2;
			}
		}
	}


}
