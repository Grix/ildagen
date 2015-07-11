///seq_dialog_yesno(id, question string)
if (controller.dialog_open) exit;
with (seqcontrol)
    {
    controller.dialog_open = 1;
    dialog = argument0;
    getint = show_question_async(argument1);
    }