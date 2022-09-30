if (keyboard_check_control())
{
	if (!controller.warning_disable)
		seq_dialog_yesno("loadproject","This will replace your current project, all unsaved work will be lost. Continue? (Cannot be undone)");
	else
		with (seqcontrol)
			load_project(get_open_filename_ext("LSG project|*.igp","","","Select LaserShowGen project file"));
}