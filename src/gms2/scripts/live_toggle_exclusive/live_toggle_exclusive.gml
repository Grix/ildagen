function live_toggle_exclusive() {
	with (livecontrol)
	{
		ds_list_set(livecontrol.filelist[| livecontrol.selectedfile], 8, !ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 8));
	}


}
