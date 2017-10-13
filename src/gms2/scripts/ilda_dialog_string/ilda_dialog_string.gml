/// @description ilda_dialog_string(id, msg, default)
/// @function ilda_dialog_string
/// @param id
/// @param  msg
/// @param  default
if (controller.dialog_open) exit;
with (controller)
{
    dialog_open = 1;
    getstr = get_string_async(argument1,argument2);
    dialog = argument0;
}
