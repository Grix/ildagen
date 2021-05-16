if (room != rm_seq)
	exit;

playing = 0;
timeline_surf_length = 0;
clean_redo_list_seq();
controller.last_room = room;

if (loadprojectflag)
	dd_seq_loadproject();
loadprojectflag = false;