function import_ildaseq_end() {
	with(controller)
	{
	    frames_toseq_importedilda();
    
		if (ild_list != -1)
		{
			ds_list_free_pool(ild_list); ild_list=-1;
		}
	}
    
	global.loading_importildaseq = 0;
	room_goto(rm_seq);
	return 1;



}
