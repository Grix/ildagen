function import_ildaseq_end() {
	with(controller)
	{
	    frames_toseq_importedilda();
    
	    ds_list_destroy(ild_list);
	}
    
	global.loading_importildaseq = 0;
	room_goto(rm_seq);
	return 1;



}
