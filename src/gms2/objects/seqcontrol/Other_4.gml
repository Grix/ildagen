if (room != rm_seq)
	exit;

playing = 0;
timeline_surf_length = 0;
controller.last_room = room;

if (loadprojectflag)
	dd_seq_loadproject();
loadprojectflag = false;