function live_toggle_resume() {
	with (livecontrol)
	{
		ds_list_set(livecontrol.filelist[| livecontrol.selectedfile], 9, !ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 9));
	}


}
