// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dropdown_playlist(){
ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-view_hport[3],"foreground",obj_dropdown);
	with (ddobj)
	{
	    num = 2;
	    event_user(1);
		ds_list_add(desc_list,"Add to playlist...");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_playlist_add);
	    ds_list_add(hl_list,1);
		ds_list_add(desc_list,"Clear playlist");
	    ds_list_add(sep_list,1);
	    ds_list_add(scr_list,dd_seq_playlist_clear);
	    ds_list_add(hl_list,1);
	}

}