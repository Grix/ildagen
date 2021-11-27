// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_seq_playlist_add(){
	
	var t_file = get_open_filename_ext("LSG project|*.igp","","","Select LaserShowGen project file");
	if (string_length(t_file) < 1 || !is_string(t_file)) 
	    exit;
	
	ds_list_add(seqcontrol.playlist_list, t_file);
		
	if (instance_exists(obj_playlist) && surface_exists(obj_playlist.surf_playlist))
		surface_free(obj_playlist.surf_playlist);
}