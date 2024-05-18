/// @description process_dialog_seq(map)
/// @function process_dialog_seq
/// @param map
function process_dialog_seq() {

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
		   add_action_history_ilda("SEQ_dialog_"+string(dialog));
		   
	      switch (dialog)
	      {
	        case "objectduration":
	        {
	            if ds_list_empty(somaster_list)
	                exit;
            
	            objectlist = ds_list_find_value(somaster_list,0);
				if (!ds_list_exists_pool(objectlist))
					break;
					
				if (controller.use_bpm)
					newduration = round(ds_map_find_value(argument[0], "value") / (controller.bpm / 60) * controller.projectfps);
				else
					newduration = round(ds_map_find_value(argument[0], "value"));
				
	            if (newduration < 1) 
	                newduration = 1;
	            newduration--;
            
	            undolisttemp = ds_list_create_pool();
	            ds_list_add(undolisttemp,objectlist);
	            ds_list_add(undolisttemp,objectlist[| 2]);
	            ds_list_add(undo_list,"r"+string(undolisttemp));
            
	            ds_list_replace(objectlist, 2, newduration);
            
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
			case "beats_shift":
	        {
	            beats_shift = ds_map_find_value(argument[0], "value");
	            obj_beatshift.stringToDraw = "Beat offset: "+string_format(seqcontrol.beats_shift,3,2);
				seqcontrol.timeline_surf_length = 0;
            
	            break;
	        }
	        case "fft_cutoff_bass_low":
	        {
	            seqcontrol.audio_fft_bass_low_cutoff = clamp(real(ds_map_find_value(argument[0], "value")), 0, 2048);
				seq_dialog_num("fft_cutoff_bass_high", "Enter higher bass window cutoff (range 0-2048, default 5)", seqcontrol.audio_fft_bass_high_cutoff);
	            break;
	        }
			case "fft_cutoff_bass_high":
	        {
	            seqcontrol.audio_fft_bass_high_cutoff = clamp(real(ds_map_find_value(argument[0], "value")), 0, 2048);
				seq_dialog_num("fft_cutoff_treble_low", "Enter lower treble window cutoff (range 0-2048, default 40)", seqcontrol.audio_fft_treble_low_cutoff);
	            break;
	        }
			case "fft_cutoff_treble_low":
	        {
	            seqcontrol.audio_fft_treble_low_cutoff = clamp(real(ds_map_find_value(argument[0], "value")), 0, 2048);
				seq_dialog_num("fft_cutoff_treble_high", "Enter higher treble window cutoff (range 0-2048, default 150)", seqcontrol.audio_fft_treble_high_cutoff);
	            break;
	        }
			case "fft_cutoff_treble_high":
	        {
	            seqcontrol.audio_fft_treble_high_cutoff = clamp(real(ds_map_find_value(argument[0], "value")), 0, 2048);
				with (seqcontrol)
					load_audio();
	            break;
	        }
			
			case "add_strobe":
			{
				strobe_period = ds_map_find_value(argument[0], "value");
				
				if (controller.use_bpm)
				{
					var t_framesPerBeat = projectfps / (controller.bpm / 60);
					strobe_period *= t_framesPerBeat;
				}
				else
					strobe_period *= projectfps
				
				seq_dialog_num("add_strobe_dutycycle", "Choose the duty cycle of the strobing (on/off ratio, from 0 to 1):", 0.5); 	
				break;
			}
			
			case "add_fadein":
			case "add_fadeout":
			case "add_strobe_dutycycle":
			{
	            var t_parameter = ds_map_find_value(argument[0], "value");
			
				for (i = 0; i < ds_list_size(somaster_list); i++)
				{
					var t_object = somaster_list[| i];
					var t_layer = find_layer_of_object(t_object);
					if (!ds_list_exists_pool(t_layer))
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
						t_envelope = ds_list_create_pool();
						ds_list_add(t_envelopelist,t_envelope);
						ds_list_add(t_envelope,"a");
						ds_list_add(t_envelope,ds_list_create_pool());
						ds_list_add(t_envelope,ds_list_create_pool());
						ds_list_add(t_envelope,0);
						ds_list_add(t_envelope,0);
					}
					var t_timelist = t_envelope[| 1];
					var t_datalist = t_envelope[| 2];
				
					var t_undolist = ds_list_create_pool();
					var t_list1 = ds_list_create_pool();
					var t_list2 = ds_list_create_pool();
					ds_list_copy(t_list1,t_timelist);
					ds_list_copy(t_list2,t_datalist);
					ds_list_add(t_undolist,t_list1);
					ds_list_add(t_undolist,t_list2);
					ds_list_add(t_undolist,t_envelope);
				
					var t_start, t_end, t_valuestart, t_valueend;
					if (dialog == "add_fadein")
					{
						if (controller.use_bpm)
						{
							var t_framesPerBeat = projectfps / (controller.bpm / 60);
							t_parameter *= t_framesPerBeat;
						}
						else
							t_parameter *= projectfps;
						
						t_start = t_object[| 0] - 1;
						t_end = t_start + t_parameter + 2;
					}
					else if (dialog == "add_fadeout")
					{
						if (controller.use_bpm)
						{
							var t_framesPerBeat = projectfps / (controller.bpm / 60);
							t_parameter *= t_framesPerBeat;
						}
						else
							t_parameter *= projectfps;
							
						t_end = t_object[| 0] + ds_list_find_value(t_object, 2) + 1;
						t_start = t_end - t_parameter - 1;
					}
					else if (dialog == "add_strobe_dutycycle")
					{
						t_start = t_object[| 0] - 1;
						t_end = t_object[| 0] + ds_list_find_value(t_object, 2) + 1;
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
					else if  (dialog == "add_strobe_dutycycle")
					{
						if (strobe_period <= 0) 
							strobe_period = 1;
						t_parameter = clamp(t_parameter, 0, 1);
					
						u = t_end-1;
						while (true)
						{
							u -= strobe_period * (t_parameter);
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
							u -= strobe_period * (1-t_parameter);
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
						/*for (u = t_end-strobe_period-1; u >= t_start+1; u -= strobe_period)
						{
							ds_list_insert(t_timelist, t_index, u+strobe_period-1);
							ds_list_insert(t_datalist, t_index, 0);
							ds_list_insert(t_timelist, t_index, u+strobe_period/2);
							ds_list_insert(t_datalist, t_index, 0);
							ds_list_insert(t_timelist, t_index, u+strobe_period/2-1);
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
				keyboard_clear(vk_control);
				mouse_clear(mouse_lastbutton);
	            break;
	        }
		
	        case "loadproject_known_filename":
	        {
	            load_project(controller.known_filename_of_load);
				keyboard_clear(keyboard_lastkey);
				keyboard_clear(vk_control);
				mouse_clear(mouse_lastbutton);
	            break;
	        }
		
			case "loaddemo":
	        {
				var t_dir = "";
//if (os_type == os_macosx)
//	t_dir = "datafiles/"
				load_project(t_dir+"demo_show.igp");
				seqcontrol.show_is_demo = true;
	            break;
	        };
          
	        case "fromseq":
	        {
	            frames_fromseq();
            
	            break;
	        }
			
	        case "clear_jump_points":
	        {
	            ds_list_clear(seqcontrol.jump_button_list);
	            ds_list_clear(seqcontrol.jump_button_list_midi);
            
	            break;
	        }
            
	        case "envelopedelete":
	        {
	            selectedenvelope_index = ds_list_find_index(env_list_to_delete,selectedenvelope);
	            if (selectedenvelope_index == -1) 
	                exit;
					
				var t_undo_list = ds_list_create_pool();
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
				
				clean_redo_list_seq();
				clean_seq_undo();
	            layer_delete_inner();
            
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
