with (livecontrol)
{
	ds_list_delete(filelist, playingfile);
	//todo free buffer etc
	
	playingfile = -1;
	if (surface_exists(browser_surf))
		surface_free(browser_surf);
	browser_surf = -1;
	playing = 0;
	frame_surf_refresh = 1;
}