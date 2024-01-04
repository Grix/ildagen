function live_change_shortcut() {
	with (livecontrol)
	{
		ds_list_set(filelist[| selectedfile], 6, -1);
	}


}
