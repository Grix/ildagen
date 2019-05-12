with (livecontrol)
{
	objectlist = filelist[| playingfile];
	
	infolist = objectlist[| 2];
        
    if (surface_exists(infolist[| 1]))
        surface_free(infolist[| 1]);
            
    if (buffer_exists(objectlist[| 1]))
        buffer_delete(objectlist[| 1]);
                
    ds_list_find_value(objectlist,0);
    ds_list_destroy(infolist);
    ds_list_destroy(objectlist);
	
	ds_list_delete(filelist, playingfile);
	
	playingfile = -1;
	if (surface_exists(browser_surf))
		surface_free(browser_surf);
	browser_surf = -1;
	playing = 0;
	frame_surf_refresh = 1;
}