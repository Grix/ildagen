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
else if (!has_loaded_default)
{
	var t_file = "default_grid.igl";
	has_loaded_default = true;
	if (file_exists(t_file))
		load_live_project(t_file);
}
loadprojectflag = false;


clean_redo_live();

ds_list_clear(midi_keys_pressed);