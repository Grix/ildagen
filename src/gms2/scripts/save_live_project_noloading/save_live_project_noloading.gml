function save_live_project_noloading() {
	//exports live project into igl file

	playing = 0;
    
	save_buffer = buffer_create(1,buffer_grow,1);

	file_loc = get_save_filename_ext("LSG Grid Files|*.igl","example"+string(current_hour) + "" + string(current_minute)+".igl","","Select LaserShowGen grid file location");
	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	mouse_clear(mouse_lastbutton);
	if (string_length(file_loc) < 1 || !is_string(file_loc)) 
	    exit;
    
	if (filename_ext(file_loc) != ".igl")
		file_loc += ".igl";
	    //show_message_new("Warning: Your filename has no .igl extension, and might not be recognized by LSG when you try to load it.\n\nIt is recommended to save the file again, with a the text .igl at the end of the name.");


	global.loadingtimeprev = get_timer();

	global.loading_saveliveproject = 1;

	global.loading_start = 0;
	global.loading_end = ds_list_size(filelist);
	global.loading_current = global.loading_start;
    
	buffer_write(save_buffer,buffer_u8,202); //version / ID
	buffer_write(save_buffer,buffer_u8,controller.projectfps); //fps
	buffer_write(save_buffer,buffer_s8,(1-masteralpha)*127);
	buffer_write(save_buffer,buffer_s8,(1-masterred)*127);
	buffer_write(save_buffer,buffer_s8,(1-masterblue)*127);
	buffer_write(save_buffer,buffer_s8,(1-mastergreen)*127);
	buffer_write(save_buffer,buffer_s8,(255-masterhue));
	buffer_write(save_buffer,buffer_s8,0);
	buffer_write(save_buffer,buffer_s8,0);
	buffer_write(save_buffer,buffer_s8,0);
	buffer_write(save_buffer,buffer_s8,0);
	buffer_write(save_buffer,buffer_u8,masteralpha_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,masterred_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,mastergreen_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,masterblue_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,masterhue_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,masterx_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,mastery_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,masterabsrot_midi_shortcut + 2);
	buffer_write(save_buffer,buffer_u8,0);
	repeat (30)
	    buffer_write(save_buffer,buffer_u8,0);
	buffer_write(save_buffer,buffer_u32,ds_list_size(filelist)); //pos 50


	var t_return = 0;
	while (t_return == 0)
		t_return = save_live_project_work();


}
