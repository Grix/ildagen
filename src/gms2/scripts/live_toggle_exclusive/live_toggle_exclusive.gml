with (livecontrol)
{
	ds_list_set(livecontrol.filelist[| livecontrol.selectedfile], 5, !ds_list_find_value(livecontrol.filelist[| livecontrol.selectedfile], 5));
}