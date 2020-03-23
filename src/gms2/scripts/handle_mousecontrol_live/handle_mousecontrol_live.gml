if (window_mouse_get_x() > tlw) 
or (window_mouse_get_y() < view_hport[3]+view_hport[4])
or (controller.dialog_open)
or (controller.menu_open)
or (instance_exists(obj_dropdown))
    exit;

var t_width = camera_get_view_width(view_get_camera(1));
var t_ystart = camera_get_view_y(view_get_camera(1));
var t_cells_per_row = ceil(t_width / (target_width_per_cell*controller.dpi_multiplier));
var t_cell_size = t_width / t_cells_per_row;

var t_row;
var t_column;

highlightfile = -1;

for (i = 0; i < ds_list_size(filelist); i++)
{
	t_column = i mod t_cells_per_row;
	t_row = i div t_cells_per_row;
	
	if (	mouse_x > t_column*t_cell_size+1		&& mouse_x < t_column*t_cell_size+1+t_cell_size
		&&	mouse_y > t_ystart+t_row*t_cell_size+1	&& mouse_y < t_ystart+t_row*t_cell_size+1+t_cell_size)
	{
		// mouse over an item cell
		
		highlightfile = i;
		
		objectlist = filelist[| i];
		var t_shortcut = "";
		if (objectlist[| 3] > 0)
		{
			t_shortcut += chr(objectlist[| 3]);
		}
		
		controller.tooltip = "Click to select and play this file ("+t_shortcut+").\nDoubleclick to open in editor mode.\nRight click for options.";
		
		if (mouse_check_button_pressed(mb_left))
		{
			if (doubleclick && selectedfile == i)
			{
				//edit object
                live_dialog_yesno("fromlive","You are about to open these frames in the editor mode. This will discard any unsaved changes in the editor. Continue? (Cannot be undone)");
			}        
			else
			{
				selectedfile = i;
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
					
					if (ds_list_find_value(filelist[| i], 6) == 0) // if restart instead of resume
						ds_list_set(ds_list_find_value(filelist[| i], 2), 0, 0);
					else 
					{
						var t_infolist = ds_list_find_value(filelist[| i], 2);
						if (ds_list_find_value(t_infolist, 0) >= ds_list_find_value(t_infolist, 2))
							ds_list_set(ds_list_find_value(filelist[| i], 2), 0, 0);
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
	}
}