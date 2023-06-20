function live_change_tile_name() {
	with (livecontrol)
	{
		live_dialog_string("set_name", "Enter descriptive name of tile:", string(livecontrol.filelist[| livecontrol.selectedfile][| 8]));
	}


}
