var t_file = file_find_next();

if (t_file != "")
{
	global.loading_importfolderlive = 1;
	if (string_lower(filename_ext(t_file)) == ".ild")
		import_ildalive(loadfolderpath+t_file);
	else if (string_lower(filename_ext(t_file)) == ".igf")
		load_frames_live(loadfolderpath+t_file);
}
else
{
	global.loading_importfolderlive = 0;
	file_find_close();
}