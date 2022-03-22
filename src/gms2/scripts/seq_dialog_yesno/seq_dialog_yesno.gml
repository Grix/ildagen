/// @description seq_dialog_yesno(id, question string)
/// @function seq_dialog_yesno
/// @param id
/// @param  question string
function seq_dialog_yesno() {
	
	log("KEYBOARD: " + string(keyboard_check(ord("O"))));
	log("force_io_reset: " + string(controller.force_io_reset));
	
	if (controller.dialog_open || controller.force_io_reset) exit;
	with (seqcontrol)
	{
	    controller.dialog_open = 1;
	    dialog = argument[0];
	    //getint = show_question_new(argument1);
	
		if (os_browser == browser_not_a_browser)
		{
			var t_map = ds_map_create();
			getint = current_time;
			t_map[? "id"] = getint;
			t_map[? "status"] = show_question(argument[1]);
			
			keyboard_clear(keyboard_lastkey);
			keyboard_clear(vk_control);
			keyboard_clear(91);
			keyboard_clear(92);
			mouse_clear(mouse_lastbutton);
			io_clear();
		
			process_dialog_seq(t_map);
			log("\nKEYBOARD: " + string(keyboard_check(ord("O"))));
			log("force_io_reset: " + string(controller.force_io_reset));
			//controller.force_io_reset = true;
		
			ds_map_destroy(t_map);
		}
		else
		    return (show_question_new(argument[1]));
	}



}
