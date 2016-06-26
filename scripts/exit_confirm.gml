if (controller.maxframes == 1) && !ds_list_size(controller.el_list)
    game_end();
    
ilda_dialog_yesno("exit","Are you sure you want to quit? Unsaved progress will be lost.");
