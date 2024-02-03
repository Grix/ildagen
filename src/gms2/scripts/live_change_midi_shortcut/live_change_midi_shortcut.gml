// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function live_change_midi_shortcut(){
	with (livecontrol)
	{
		ds_list_set(filelist[| selectedfile], 13, -1);
	}

}