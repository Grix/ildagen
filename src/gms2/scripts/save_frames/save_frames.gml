function save_frames() {
	var t_file_loc = get_save_filename_ext("LSG frames|*.igf","example"+string(current_hour) + "" + string(current_minute)+".igf","","Select LaserShowGen frames file location");
	save_frames_inner(t_file_loc);
}
