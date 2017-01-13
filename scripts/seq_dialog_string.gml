///seq_dialog_string(id, msg, default)
if (controller.dialog_open) 
    exit;
with (seqcontrol)
{
    controller.dialog_open = 1;
    getstr = get_string_async(argument1,argument2);
    dialog = argument0;
}
