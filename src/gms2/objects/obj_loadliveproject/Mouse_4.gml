if (instance_exists(obj_dropdown))
    exit;
	
if (!verify_serial(1))
	exit;
live_dialog_yesno("loadliveproject","This will replace your current grid of files, all unsaved work will be lost. Continue? (Cannot be undone)");

