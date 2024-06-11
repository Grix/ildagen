function live_unbind_shortcut() {
	with (livecontrol)
	{
		ds_list_set(filelist[| selectedfile], 6, 0);
		ds_list_set(filelist[| selectedfile], 13, -2);
	}


}
