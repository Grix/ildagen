// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_seq_playlist_clear(){
	
	ds_list_clear(seqcontrol.playlist_list);
		
	if (instance_exists(obj_playlist) && surface_exists(obj_playlist.surf_playlist))
		surface_free(obj_playlist.surf_playlist);
}