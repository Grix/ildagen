var t_width = view_wport[1];
var t_ystart = view_yport[1];
var t_cells_per_row = ceil(t_width / target_width_per_cell);
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
		
		if (mouse_check_button_pressed(mb_left))
		{
			playingfile = i;
			if (surface_exists(browser_surf))
				surface_free(browser_surf);
			browser_surf = -1;
			log(playingfile);
		}
	}
}