if (view_wport[4] > frame_surf_w)
	draw_surface_stretched(argument[0], 0,0, view_wport[4], view_wport[4]);
else
	draw_surface_part(argument[0], 0,0, frame_surf_w, frame_surf_w, 0,0);