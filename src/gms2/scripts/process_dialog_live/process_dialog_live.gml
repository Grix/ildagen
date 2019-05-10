/// @description process_dialog_live(map)
/// @function process_dialog_live
/// @param map

//Get integer
new_id = ds_map_find_value(argument[0], "id");
controller.dialog_open = 0;
controller.menu_open = 0;

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
