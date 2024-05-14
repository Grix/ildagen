function dd_seq_object_duration() {
	with (seqcontrol)
	{
	    if (ds_list_empty(seqcontrol.somaster_list))
	        exit;
        
	    objectlist = ds_list_find_value(somaster_list,0);
		if (!ds_list_exists_pool(objectlist))
		{
			ds_list_delete(somaster_list, 0);
			exit;
		}
		
		if (controller.use_bpm)
			seq_dialog_num("objectduration","Enter the new duration these object(s) should last on the timeline, in number of beats (at "+string(controller.bpm)+" BPM). If the duration is longer than the object itself, it will loop.",((objectlist[| 2]+1) / controller.projectfps) * (controller.bpm / 60));
		else
			seq_dialog_num("objectduration","Enter the new duration these object(s) should last on the timeline, in number of frames (at "+string(seqcontrol.projectfps)+" FPS). If the duration is longer than the object itself, it will loop.",objectlist[| 2]+1);
		
	}



}
