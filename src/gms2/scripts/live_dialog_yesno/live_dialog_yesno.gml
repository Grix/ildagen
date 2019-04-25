/// @description seq_dialog_yesno(id, question string)
/// @function seq_dialog_yesno
/// @param id
/// @param  question string
if (controller.dialog_open) exit;
with (livecontrol)
{
    controller.dialog_open = 1;
    dialog = argument0;
    getint = show_question_new(argument1);
}
