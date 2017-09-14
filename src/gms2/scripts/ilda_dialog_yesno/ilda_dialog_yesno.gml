/// @description ilda_dialog_yesno(id,msg)
/// @function ilda_dialog_yesno
/// @param id
/// @param msg
if (controller.dialog_open) exit;
with (controller)
{
    dialog_open = 1;
    dialog = argument0;
    getint = show_question_new(argument1);
}
