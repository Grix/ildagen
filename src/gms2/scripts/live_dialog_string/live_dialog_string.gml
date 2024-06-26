/// @description live_dialog_string(id, msg, default)
/// @function live_dialog_string
/// @param id
/// @param  msg
/// @param  default
function live_dialog_string() {
	if (controller.dialog_open) exit;
	with (livecontrol)
	{
	    controller.dialog_open = 1;
		dialog = argument[0];
	
		if (os_type == os_linux)//os_browser == browser_not_a_browser)
		{
			var t_map = ds_map_create();
			getstr = current_time;
			t_map[? "id"] = getstr;
			t_map[? "status"] = 1;
			t_map[? "result"] = get_string(argument[1],argument[2]);
		
			process_dialog_live(t_map);
		
			ds_map_destroy(t_map);
		}
		else
		{
			getstr = get_string_async(argument[1],argument[2]);
		}
	}



}
