// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clear_timeline_jump_points(){
	if (!ds_list_empty(seqcontrol.jump_button_list))
		seq_dialog_yesno("clear_jump_points", "Are you sure you want to clear all jump points on the timeline? (Cannot be undone)");
}