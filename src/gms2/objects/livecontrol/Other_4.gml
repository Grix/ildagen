if (room != rm_live)
	exit;

playing = 0;
frame = 0;
framehr = 0;
if (surface_exists(browser_surf))
	surface_free(browser_surf);
browser_surf = -1;
frame_surf_refresh = 1;

if (loadprojectflag)
	dd_live_loadproject();
loadprojectflag = false;
clean_redo_live();