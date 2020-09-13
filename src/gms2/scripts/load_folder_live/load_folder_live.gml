function load_folder_live(argument0) {
	if (!verify_serial(1))
		return;

	loadfolderpath = argument0;

	if (loadfolderpath  == "")
		return;
	
	var t_file = file_find_first(loadfolderpath +"*", 0);

	if (t_file != "")
	{
		global.loading_importfolderlive = 1;
		if (string_lower(filename_ext(t_file)) == ".ild")
			import_ildalive(loadfolderpath+t_file);
		else if (string_lower(filename_ext(t_file)) == ".igf")
			load_frames_live(loadfolderpath+t_file);
	}


}
