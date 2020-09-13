function dd_seq_object_duration() {
	with (seqcontrol)
	{
	    if (ds_list_empty(seqcontrol.somaster_list))
	        exit;
        
	    objectlist = ds_list_find_value(somaster_list,0);
		if (!ds_list_exists(objectlist))
		{
			ds_list_delete(somaster_list, 0);
			exit;
		}
	
	    infolisttomove = ds_list_find_value(objectlist,2); 
	    seq_dialog_num("objectduration","Enter the number of frames these object(s) should last on the timeline. If the number of frames is larger than the object itself, it will loop.",infolisttomove[| 0]+1);
	}



}
