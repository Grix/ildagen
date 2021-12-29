function save_frames_quick() {
	with (controller)
	{
		if (os_browser == browser_not_a_browser)
		{
			if (filepath == "")
				save_frames();
			else
				save_frames_inner(controller.filepath);
		}
		else
		{
			if (filepath == "")
				ilda_dialog_string("saveframes","Enter the name of the LaserShowGen frames IGF file","example"+string(current_hour) + "" + string(current_minute)+".igf");
			else
			{
				file_loc = filename_name(filepath);
				save_frames_html5();
			}
		}
	}
}
