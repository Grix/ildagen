/// @description ilda_dialog_yesno(id,msg)
/// @function ilda_dialog_yesno
/// @param id
/// @param msg
function ilda_dialog_yesno() {
	if (controller.dialog_open) exit;
	with (controller)
	{
	    dialog_open = 1;
	    dialog = argument[0];
	    //getint = show_question_new(argument1);
	
		if (os_browser == browser_not_a_browser)
		{
			var t_map = ds_map_create();
			getint = current_time;
			t_map[? "id"] = getint;
			t_map[? "status"] = show_question(argument[1]);
		
			process_dialog_ilda(t_map);
		
			ds_map_destroy(t_map);
		}
		else
		    return (show_question_new(argument[1]));
	}



}
