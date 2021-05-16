/// @description process_dialog_seq(map)
/// @function process_dialog_seq
/// @param map
function process_dialog_seq() {

	if (!ds_exists(argument[0], ds_type_map))
	    exit;

	//Get integer
	new_id = ds_map_find_value(argument[0], "id");
	controller.dialog_open = 0;
	controller.menu_open = 0;

	keyboard_clear(keyboard_lastkey);
	mouse_clear(mouse_lastbutton);

	if (new_id == getint)
	{ 
	    if ds_map_find_value(argument[0], "status")
	   {
	      switch (dialog)
	      {
	        case "objectduration":
	        {
	            if ds_list_empty(somaster_list)
	                exit;
            
	            objectlist = ds_list_find_value(somaster_list,0);
				if (!ds_list_exists(objectlist))
					break;
	            infolisttomove = ds_list_find_value(objectlist,2);
	            newduration = round(ds_map_find_value(argument[0], "value"));
	            if (newduration < 1) 
	                newduration = 1;
	            newduration--;
            
	            undolisttemp = ds_list_create();
	            ds_list_add(undolisttemp,infolisttomove);
	            ds_list_add(undolisttemp,infolisttomove[| 0]);
	            ds_list_add(undo_list,"r"+string(undolisttemp));
            
	            ds_list_replace(infolisttomove,0,newduration);
            
	            //todo: check for collisions
			
				timeline_surf_length = 0;
				clean_redo_list_seq();
            
	            break;
	        }
	        case "fps":
	        {
	            projectfps = clamp(ds_map_find_value(argument[0], "value"),1,999);
	            controller.projectfps = projectfps;
				timeline_surf_length = 0;
	            break;
	        }
	        case "audioshift":
	        {
	            audioshift = ds_map_find_value(argument[0], "value");
	            obj_audioshift.stringToDraw = "Offset: "+string_format(seqcontrol.audioshift,4,1)+"ms";
            
	            break;
	        }
			case "add_fadein":
			case "add_fadeout":
			case "add_strobe":
			{
	            var t_parameter = ds_map_find_value(argument[0], "value")*controller.projectfps;
			
				for (i = 0; i < ds_list_size(somaster_list); i++)
				{
					var t_object = somaster_list[| i];
					var t_layer = find_layer_of_object(t_object);
					if (!ds_list_exists(t_layer))
						continue;
					
					var t_envelopelist = t_layer[| 0];
					var t_envelope = -1;
					for (j = 0; j < ds_list_size(t_envelopelist); j++)
					{
						if (ds_list_find_value(t_envelopelist[| j], 0) == "a")
						{
							t_envelope = t_envelopelist[| j];
							break;
						}
					}
					if (t_envelope == -1)
					{
						t_envelope = ds_list_create();
						ds_list_add(t_envelopelist,t_envelope);
						ds_list_add(t_envelope,"a");
						ds_list_add(t_envelope,ds_list_create());
						ds_list_add(t_envelope,ds_list_create());
						ds_list_add(t_envelope,0);
						ds_list_add(t_envelope,0);
					}
					var t_timelist = t_envelope[| 1];
					var t_datalist = t_envelope[| 2];
				
					var t_undolist = ds_list_create();
					var t_list1 = ds_list_create();
					var t_list2 = ds_list_create();
					ds_list_copy(t_list1,t_timelist);
					ds_list_copy(t_list2,t_datalist);
					ds_list_add(t_undolist,t_list1);
					ds_list_add(t_undolist,t_list2);
					ds_list_add(t_undolist,t_envelope);
				
					var t_start, t_end, t_valuestart, t_valueend;
					if (dialog == "add_fadein")
					{
						t_start = t_object[| 0] - 1;
						t_end = t_start + t_parameter + 2;
					}
					else if (dialog == "add_fadeout")
					{
						t_end = t_object[| 0] + ds_list_find_value(t_object[| 2], 0) + 1;
						t_start = t_end - t_parameter - 1;
					}
					else if (dialog == "add_strobe")
					{
						t_start = t_object[| 0] - 1;
						t_end = t_object[| 0] + ds_list_find_value(t_object[| 2], 0) + 1;
					}
					t_valuestart = find_envelope_value(t_datalist, t_timelist, t_start);
					t_valueend = find_envelope_value(t_datalist, t_timelist, t_end);
					if (is_undefined(t_valuestart))
						t_valuestart = 0;
					if (is_undefined(t_valueend))
						t_valueend = 0;
		
			        for (u = 0; u < ds_list_size(t_timelist); u++)
			        {
			            if (t_timelist[| u] >= t_start && t_timelist[| u] <= t_end)
			            {
			                ds_list_delete(t_timelist,u);
			                ds_list_delete(t_datalist,u);
			                u--;
			            }
			        }
				
					for (t_index = 0; t_index < ds_list_size(t_timelist); t_index++)
					{
						if (t_timelist[| t_index] > t_start)
							break;
					}
				
					ds_list_insert(t_timelist, t_index, t_end);
					ds_list_insert(t_datalist, t_index, t_valueend);
				
					if (dialog == "add_fadein")
					{
						ds_list_insert(t_timelist, t_index, t_end-1);
						ds_list_insert(t_datalist, t_index, 0);
						ds_list_insert(t_timelist, t_index, t_start+1);
						ds_list_insert(t_datalist, t_index, 64);
					}
					else if (dialog == "add_fadeout")
					{
						ds_list_insert(t_timelist, t_index, t_end-1);
						ds_list_insert(t_datalist, t_index, 64);
						ds_list_insert(t_timelist, t_index, t_start+1);
						ds_list_insert(t_datalist, t_index, 0);
					}
					else if  (dialog == "add_strobe")
					{
						if (t_parameter <= 0) 
							t_parameter = 1;
					
						u = t_end-1;
						while (true)
						{
							u -= t_parameter/2;
							if (u <= t_start+2)
							{
								ds_list_insert(t_timelist, t_index, t_start+1);
								ds_list_insert(t_datalist, t_index, 0);	
								break;
							}
							ds_list_insert(t_timelist, t_index, u);
							ds_list_insert(t_datalist, t_index, 0);
							ds_list_insert(t_timelist, t_index, u-1);
							ds_list_insert(t_datalist, t_index, 64);
							u -= t_parameter/2;
							if (u <= t_start+2)
							{
								ds_list_insert(t_timelist, t_index, t_start+1);
								ds_list_insert(t_datalist, t_index, 64);	
								break;
							}
							ds_list_insert(t_timelist, t_index, u);
							ds_list_insert(t_datalist, t_index, 64);
							ds_list_insert(t_timelist, t_index, u-1);
							ds_list_insert(t_datalist, t_index, 0);
						}
						/*for (u = t_end-t_parameter-1; u >= t_start+1; u -= t_parameter)
						{
							ds_list_insert(t_timelist, t_index, u+t_parameter-1);
							ds_list_insert(t_datalist, t_index, 0);
							ds_list_insert(t_timelist, t_index, u+t_parameter/2);
							ds_list_insert(t_datalist, t_index, 0);
							ds_list_insert(t_timelist, t_index, u+t_parameter/2-1);
							ds_list_insert(t_datalist, t_index, 64);
							ds_list_insert(t_timelist, t_index, u);
							ds_list_insert(t_datalist, t_index, 64);
						}*/
						ds_list_insert(t_timelist, t_index, t_start+1);
						ds_list_insert(t_datalist, t_index, 64);
					}
				
					ds_list_insert(t_timelist, t_index, t_start);
					ds_list_insert(t_datalist, t_index, t_valuestart);
				
					ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
				}
			
				seqcontrol.timeline_surf_length = 0;
				clean_redo_list_seq();
				break;
			}
	        case "projectclear":
	        {
	            clear_project();
            
	            break;
	        }
	        case "loadproject":
	        {
	            load_project(get_open_filename_ext("LSG project|*.igp","","","Select LaserShowGen project file"));
				keyboard_clear(keyboard_lastkey);
				mouse_clear(mouse_lastbutton);
	            break;
	        }
		
			case "loaddemo":
	        {
				var t_dir = "";
//if (os_type == os_macosx)
//	t_dir = "datafiles/"
				load_project(t_dir+"demo_show.igp")
	            break;
	        };
          
	        case "fromseq":
	        {
	            frames_fromseq();
            
	            break;
	        }
            
	        case "envelopedelete":
	        {
	            selectedenvelope_index = ds_list_find_index(env_list_to_delete,selectedenvelope);
	            if (selectedenvelope_index == -1) 
	                exit;
					
				var t_undo_list = ds_list_create();
				ds_list_add(t_undo_list, selectedenvelope);
				ds_list_add(t_undo_list, env_list_to_delete);
				ds_list_add(undo_list, "x"+string(t_undo_list));
            
	            ds_list_delete(env_list_to_delete,selectedenvelope_index);
				timeline_surf_length = 0;
				clean_redo_list_seq();
            
	            break;
	        }
            
	        case "layerdelete":
	        {
	            _layer = layertodelete;
	            selectedlayer = ds_list_find_index(layer_list,_layer);
	            if (selectedlayer == -1)
	                exit;
	            num_objects = ds_list_size(_layer[| 1]);
	            ds_list_clear(somaster_list);
				clean_redo_list_seq();
	            repeat (num_objects)   
	            {
	                ds_list_add(somaster_list,ds_list_find_value(_layer[| 1],0));
	                seq_delete_object_noundo();
	            }
	            ds_list_destroy(_layer[| 1]);
            
	            envelope_list = ds_list_find_value(_layer,0);
	            num_objects = ds_list_size(envelope_list);
	            repeat (num_objects)   
	            {
	                envelope = ds_list_find_value(envelope_list,0);
	                ds_list_destroy(ds_list_find_value(envelope,1));
	                ds_list_destroy(ds_list_find_value(envelope,2));
	                ds_list_destroy(envelope);
	                ds_list_delete(envelope_list,0);
	            }
	            ds_list_destroy(envelope_list);
            
	            var t_dac_list = ds_list_find_value(_layer,5);
	            num_objects = ds_list_size(t_dac_list);
	            repeat (num_objects)  
	                ds_list_destroy(ds_list_find_value(t_dac_list,0));
	            ds_list_destroy(t_dac_list);
            
	            ds_list_destroy(_layer);
	            ds_list_delete(layer_list,selectedlayer);
            
	            selectedlayer = 0;
	            selectedx = 0;
				timeline_surf_length = 0;
				frame_surf_refresh = 1;
				clean_redo_list_seq();
            
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
	          switch (dialog)
	        {
	            case ("layer_rename"):
	            {
	                var t_thisprojlist = seqcontrol.layer_list[| settingscontrol.projectortoselect];
	                t_thisprojlist[| 4] = ds_map_find_value(argument[0], "result");
	                projectorlist_update();
	                break;
	            }
	        }
	      }
	   }
	}



}
