function live_toggle_loop() {
	with (livecontrol)
	{
		ds_list_set(livecontrol.filelist[| livecontrol.selectedfile], 4, !ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 4));
	}


}
