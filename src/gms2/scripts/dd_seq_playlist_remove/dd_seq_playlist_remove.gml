// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_seq_playlist_remove(){
	if (seqcontrol.playlist_list_to_select < ds_list_size(seqcontrol.playlist_list))
		ds_list_delete(seqcontrol.playlist_list, seqcontrol.playlist_list_to_select);
		
	if (instance_exists(obj_playlist) && surface_exists(obj_playlist.surf_playlist))
		surface_free(obj_playlist.surf_playlist);
}