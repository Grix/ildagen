/// @description ilda_dialog_num(id, message, default)
/// @function ilda_dialog_num
/// @param id
/// @param  message
/// @param  default
function ilda_dialog_num(argument0, argument1, argument2) {
	if (controller.dialog_open) exit;
	with (controller)
	{
	    dialog_open = 1;
	    getint = get_integer_async(argument1,argument2);
	    show_debug_message(getint);
	    dialog = argument0;
	}



}
