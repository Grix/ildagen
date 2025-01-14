function exit_confirm() {
	
	if (window_has_focus())
		ilda_dialog_yesno("exit","Are you sure you want to quit? Unsaved progress will be lost.");
	else
		game_end();



}
