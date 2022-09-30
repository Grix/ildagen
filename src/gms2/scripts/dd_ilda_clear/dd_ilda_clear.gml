function dd_ilda_clear() {
	if (!controller.warning_disable)
		ilda_dialog_yesno("clearall","Are you sure you want to create a new file? All unsaved changes will be lost. (Cannot be undone)");
	else
		with (controller)
			clear_all();
}
