with (livecontrol)
{
	ds_list_set(filelist[| playingfile], 3, -1);

	if (surface_exists(browser_surf))
		surface_free(browser_surf);
	browser_surf = -1;
}