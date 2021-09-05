function live_toggle_hold() {
	with (livecontrol)
	{
		ds_list_set(livecontrol.filelist[| livecontrol.selectedfile], 7, !ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 7));
		livecontrol.filelist[| livecontrol.selectedfile][| 0] = 0; // stop playing
	}


}
