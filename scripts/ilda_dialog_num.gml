///ilda_dialog_num(id, message, default)
if (controller.dialog_open) exit;
with (controller)
{
    dialog_open = 1;
    getint = get_integer_async(argument1,argument2);
    show_debug_message(getint);
    dialog = argument0;
}
