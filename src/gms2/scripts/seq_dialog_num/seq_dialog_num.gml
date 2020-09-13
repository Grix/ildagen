/// @description seq_dialog_num(id, string, default)
/// @function seq_dialog_num
/// @param id
/// @param  string
/// @param  default
function seq_dialog_num(argument0, argument1, argument2) {
	if (controller.dialog_open) exit;
	with (seqcontrol)
	{
	    controller.dialog_open = 1;
	    getint = get_integer_async(argument1,argument2);
	    dialog = argument0;
	}



}
