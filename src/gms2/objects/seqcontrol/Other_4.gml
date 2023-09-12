if (room != rm_seq)
	exit;

playing = 0;
timeline_surf_length = 0;
clean_redo_list_seq();

if (loadprojectflag)
	dd_seq_loadproject();
loadprojectflag = false;

update_dac_list_isused();