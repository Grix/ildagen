/// @description process_dialog_live(map)
/// @function process_dialog_live
/// @param map
function process_dialog_live() {

	controller.dialog_open = 0;
	controller.menu_open = 0;

	keyboard_clear(keyboard_lastkey);
	keyboard_clear(vk_control);
	keyboard_clear(91);
	keyboard_clear(92);
	mouse_clear(mouse_lastbutton);
	io_clear();
	
	if (!ds_exists(argument[0], ds_type_map))
	    exit;

	//Get integer
	new_id = ds_map_find_value(argument[0], "id");

	if (new_id == getint)
	{ 
	    if ds_map_find_value(argument[0], "status")
	   {
	      switch (dialog)
	      {
	        case "fromlive":
	        {
	            frames_fromlive();
            
	            break;
	        }  
			case "loadliveproject":
			{
				load_live_project(get_open_filename_ext("LSG Live Grid|*.igl","","","Select LaserShowGen Live grid file"));
				keyboard_clear(keyboard_lastkey);
				keyboard_clear(vk_control);
				mouse_clear(mouse_lastbutton);
				break;
			}
			case "loadliveproject_known_filename":
			{
				load_live_project(controller.known_filename_of_load);
				keyboard_clear(keyboard_lastkey);
				keyboard_clear(vk_control);
				mouse_clear(mouse_lastbutton);
				break;
			}
			case "clearproject":
			{
				clear_live_project();
				break;
			}
	      }
	    }
	}
	else if (new_id == getstr)
	{
	   if ds_map_find_value(argument[0], "status")
	   {
	     if ds_map_find_value(argument[0], "result") != ""
	      {
	        /*switch (dialog)
	        {
	            case ("layer_rename"):
	            {
	                var t_thisprojlist = seqcontrol.layer_list[| settingscontrol.projectortoselect];
	                t_thisprojlist[| 4] = ds_map_find_value(argument[0], "result");
	                projectorlist_update();
	                break;
	            }
	        }*/
	      }
	   }
	}



}
