// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_ctrl_string(){
	if (os_type == os_macosx)
		return "Cmd";
	else
		return "Ctrl";
}