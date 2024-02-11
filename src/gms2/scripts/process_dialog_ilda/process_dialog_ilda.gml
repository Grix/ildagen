/// @description process_dialog_ilda(map)
/// @function process_dialog_ilda
/// @param map
function process_dialog_ilda() {

	//what a mess
	dialog_open = 0;
	menu_open = 0;

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
	    /*if (dialog == "update")
	    {
	        updatecheckenabled = ds_map_find_value(argument[0], "status");
	        if (os_type != os_linux)
				ini_filename = "settings.ini";
			else
				ini_filename = game_save_id + "settings.ini";
	        ini_open(ini_filename);
	        ini_write_real("main","updatecheck",updatecheckenabled);
	        ini_close();
	        if (updatecheckenabled)
	        {
	            if (os_type == os_macosx)
					updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version_mac.txt");
				else
					updateget = http_get("https://raw.githubusercontent.com/Grix/ildagen/master/version.txt");
	        }
	    }  */

	    if ds_map_find_value(argument[0], "status")
	    {
	        switch (dialog)
	        {
	            case "exit":
	            {
	                game_end();
	                break;
	            }
	            case "preset_delete":
	            {
	                ds_map_destroy(profile_list[| profiletoselect]);
	                ds_list_delete(profile_list, profiletoselect);
                
	                if (ds_list_size(profile_list) == 0)
	                {
		                if (os_type != os_linux)
							ini_open("settings.ini");
						else
							ini_open(game_save_id + "settings.ini");
	                    num = 0;
	                    while (1)
	                    {
	                        var t_projectorstring = "projector_"+string(num);
	                        if (ini_section_exists(t_projectorstring))
	                            ini_section_delete(t_projectorstring);
	                        else
	                            break;
	                        num++;
	                    }
	                    ini_close();
	                    load_settings();
	                }
	                else if (projector >= profiletoselect) 
	                {
	                    projector = 0;
	                    load_profile();
	                }
                
	                with (obj_profiles)
	                    surface_free(surf_profilelist);
                        
	                break;
	            }
            
	            case "toseqreplace":
	            {
	                frames_toseq();
                
	                break;
	            }
			
				case "tolivereplace":
	            {
	                frames_tolive();
                
	                break;
	            }
          
	            case "updatefound":
	            {
					if (os_type == os_windows)
					{
						file = http_get_file("https://github.com/Grix/ildagen/releases/download/v"+versionnew+"/LaserShowGen-"+versionnew+"-Installer.exe","temp\\update.exe");
						show_message_new("Download started. Please click OK and the program will exit and installation start shortly..");
					}
					else if (os_type == os_macosx)
						url_open("https://github.com/Grix/ildagen/releases/download/v"+versionnew+"/LaserShowGen-"+versionnew+"-Mac.dmg");
					else if (os_type == os_linux)
						url_open("https://github.com/Grix/ildagen/releases/download/v"+versionnew+"/LaserShowGen-"+versionnew+"-Linux.AppImage");
				
	                break;
	            }    
	            case "maxdist":
	          {
	              opt_maxdist = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }
	            case "blankshift": 
	          {
	              opt_blankshift = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }
	            case "redshift":
	          {
	              opt_redshift = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }
	            case "greenshift":
	          {
	              opt_greenshift = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }
	            case "blueshift":
	          {
	              opt_blueshift = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }
	            case "maxdwell":
	          {
	              opt_maxdwell = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }  
	            case "maxdwell_blank":
	          {
	              opt_maxdwell_blank = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }  
	            case "scanspeed":
	          {
	              opt_scanspeed = ds_map_find_value(argument[0], "value");
	              save_profile();
              
	              break;
	          }
	            case "wavet":
	          {
	              wave_period = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "waveamp":
	          {
	              wave_amp = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "waveoffset":
	          {
	              wave_offset = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "shapefuncpoints":
	          {
	              shapefunc_cp = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "colorfreq":
	          {
	              color_freq = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "colordc":
	          {
	              color_dc = clamp(ds_map_find_value(argument[0], "value"),0,1);
              
	              break;
	          }
	            case "colorperiod":
	          {
	              color_period = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "coloroffset":
	          {
	              color_offset = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "blankoffset":
	          {
	              blank_offset = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "blankdc":
	          {
	              blank_dc = clamp(ds_map_find_value(argument[0], "value"),0,1);
              
	              break;
	          }
	            case "aniblankdc":
	          {
	              aniblank_dc = clamp(ds_map_find_value(argument[0], "value"),0,1);
              
	              break;
	          }
	            case "blankperiod":
	          {
	              blank_period = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "blankfreq":
	          {
	              blank_freq = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
              
	            //ANI
	            case "aniblankoffset":
	          {
	              aniblank_offset = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "anicolordc":
	          {
	              anicolor_dc = clamp(ds_map_find_value(argument[0], "value"),0,1);
              
	              break;
	          }
	            case "anicoloroffset":
	          {
	              anicolor_offset = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "aniwaveoffset":
	          {
	              aniwave_offset = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "aniwaveamp":
	          {
	              aniwave_amp = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
              
	              //COLOR
	            case "c1r":
	          {
	              color1 = make_colour_rgb(clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_green(color1),color_get_blue(color1));
	              break;
	          }
	            case "c1g":
	          {
	              color1 = make_colour_rgb(color_get_red(color1),clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_blue(color1));
              
	              break;
	          }
	            case "c1b":
	          {
	              color1 = make_colour_rgb(color_get_red(color1),color_get_green(color1),clamp(ds_map_find_value(argument[0], "value"),0,255));
              
	              break;
	          }
	            case "c2r":
	          {
	              color2 = make_colour_rgb(clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_green(color2),color_get_blue(color2));
              
	              break;
	          }
	            case "c2g":
	          {
	              color2 = make_colour_rgb(color_get_red(color2),clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_blue(color2));
              
	              break;
	          }
	            case "c2b":
	          {
	              color2 = make_colour_rgb(color_get_red(color2),color_get_green(color2),clamp(ds_map_find_value(argument[0], "value"),0,255));
              
	              break;
	          }
	            case "red_scale":
	          {
	              red_scale = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "green_scale":
	          {
	              green_scale = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "blue_scale":
	          {
	              blue_scale = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "intensity_master_scale":
	          {
	              intensity_master_scale = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "red_scale_lower":
	          {
	              red_scale_lower = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "green_scale_lower":
	          {
	              green_scale_lower = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "blue_scale_lower":
	          {
	              blue_scale_lower = clamp(ds_map_find_value(argument[0], "value")/100,0,1);
	              update_colors_scalesettings();
	              save_profile();
	              break;
	          }
	            case "anirep":
	          {
	              anirep = ds_map_find_value(argument[0], "value");
	              break;
	          }
	            case "c3r":
	          {
	              enddotscolor = make_colour_rgb(clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_green(enddotscolor),color_get_blue(enddotscolor));
              
	              break;
	          }
	            case "c3g":
	          {
	              enddotscolor = make_colour_rgb(color_get_red(enddotscolor),clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_blue(enddotscolor));
              
	              break;
	          }
	            case "c3b":
	          {
	              enddotscolor = make_colour_rgb(color_get_red(enddotscolor),color_get_green(enddotscolor),clamp(ds_map_find_value(argument[0], "value"),0,255));
              
	              break;
	          }
	              //ANI COLOR
	            case "ac1r":
	          {
	              anicolor1 = make_colour_rgb(clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_green(anicolor1),color_get_blue(anicolor1));
              
	              break;
	          }
	            case "ac1g":
	          {
	              anicolor1 = make_colour_rgb(color_get_red(anicolor1),clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_blue(anicolor1));
              
	              break;
	          }
	            case "ac1b":
	          {
	              anicolor1 = make_colour_rgb(color_get_red(anicolor1),color_get_green(anicolor1),clamp(ds_map_find_value(argument[0], "value"),0,255));
              
	              break;
	          }
	            case "ac2r":
	          {
	              anicolor2 = make_colour_rgb(clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_green(anicolor2),color_get_blue(anicolor2));
              
	              break;
	          }
	            case "ac2g":
	          {
	              anicolor2 = make_colour_rgb(color_get_red(anicolor2),clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_blue(anicolor2));
              
	              break;
	          }
	            case "ac2b":
	          {
	              anicolor2 = make_colour_rgb(color_get_red(anicolor2),color_get_green(anicolor2),clamp(ds_map_find_value(argument[0], "value"),0,255));
              
	              break;
	          }
	            case "ac3r":
	          {
	              anienddotscolor = make_colour_rgb(clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_green(anienddotscolor),color_get_blue(anienddotscolor));
              
	              break;
	          }
	            case "ac3g":
	          {
	              anienddotscolor = make_colour_rgb(color_get_red(anienddotscolor),clamp(ds_map_find_value(argument[0], "value"),0,255),color_get_blue(anienddotscolor));
              
	              break;
	          }
	            case "ac3b":
	          {
	              anienddotscolor = make_colour_rgb(color_get_red(anienddotscolor),color_get_green(anienddotscolor),clamp(ds_map_find_value(argument[0], "value"),0,255));
              
	              break;
	          }
              
	            case "aniscale":
	          {
	              scalex = ds_map_find_value(argument[0], "value");
	              scaley = scalex;
	              reapply_trans();
              
              
	              break;
	          }            
              
	            case "anirot":
	          {
	              anirot = ds_map_find_value(argument[0], "value");
	              reapply_trans();
              
              
	              break;
	          }
            
	            case "clearall":
	          {
	              clear_all();
              
	              break;
	          }
              
	            case "loadfile":
	          {
	              load_frames(get_open_filename_ext("LSG frames|*.igf","","","Select LaserShowGen frames file"));
					keyboard_clear(keyboard_lastkey);
					keyboard_clear(vk_control);
					mouse_clear(mouse_lastbutton);
	              break;
	          }
			  
			    case "loadfile_known_filename":
	          {
	              load_frames(known_filename_of_load);
					keyboard_clear(keyboard_lastkey);
					keyboard_clear(vk_control);
					mouse_clear(mouse_lastbutton);
	              break;
	          }
            
	            case "dotintensity":
	          {
	              ds_list_add(undo_list,"d"+string(dotmultiply))
            
	              dotmultiply = ds_map_find_value(argument[0], "value");
	              dotmultiply = clamp(dotmultiply,1,500);
              
	              break;
	          }
	            case "onion_number":
	          {
	              onion_number = ds_map_find_value(argument[0], "value");
	              frame_surf_refresh = 1;
              
	              break;
	          }
	            case "onion_alpha":
	          {
	              onion_alpha = clamp(ds_map_find_value(argument[0], "value"),0,1);
	              frame_surf_refresh = 1;
              
	              break;
	          }
	            case "onion_dropoff":
	          {
	              onion_dropoff = clamp(ds_map_find_value(argument[0], "value"),0,1);
	              frame_surf_refresh = 1;
              
	              break;
	          }
	            case "fontsize":
	          {
	              font_size = clamp(ds_map_find_value(argument[0], "value"),1,128);
	              break;
	          }
			    case "fontspacing":
	          {
	              font_spacing = clamp(ds_map_find_value(argument[0], "value"),0,128);
	              break;
	          }
              
	            case "res":
	          {
	              ds_list_add(undo_list,"r"+string(resolution))
            
	              resolution = ds_map_find_value(argument[0], "value");
	              if (resolution < 4) resolution = 4;
	              if (resolution > $8000) resolution = $8000;
              
	              break;
	          }
              
	            case "scopestart":
	          {
				  var t_value = round(ds_map_find_value(argument[0], "value"))-1;
				  if (t_value > scope_end)
					show_message_new("NB: Start of scope cannot be later than the end of scope.");
					
					var t_undolist = ds_list_create_pool();
					ds_list_add(t_undolist, scope_start);
					ds_list_add(t_undolist, scope_end);
					ds_list_add(undo_list,"c"+string(t_undolist));
					
	              scope_start = clamp(t_value,0,scope_end);
	              frame = scope_start;
	              framehr = scope_start;
	              frame_surf_refresh = 1;
	              refresh_minitimeline_flag = 1;
              
	              break;
	          }
              
	            case "scopeend":
	          {
				  var t_value = round(ds_map_find_value(argument[0], "value"))-1;
				  if (t_value < scope_start)
					show_message_new("NB: End of scope cannot be earlier than the start of scope.");
				
					var t_undolist = ds_list_create_pool();
					ds_list_add(t_undolist, scope_start);
					ds_list_add(t_undolist, scope_end);
					ds_list_add(undo_list,"c"+string(t_undolist));
				
	              scope_end = clamp(t_value,scope_start,maxframes-1);
	              refresh_minitimeline_flag = 1;
              
	              break;
	          }
              
	            case "fps":
	          {
	              seqcontrol.projectfps = clamp(ds_map_find_value(argument[0], "value"),1,99);
	              projectfps = seqcontrol.projectfps;
	              refresh_minitimeline_flag = 1;
              
	              break;
	          }
              
	            case "shaking_sdevset":
	          {
	              shaking_sdev = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
	            case "anishaking_sdevset":
	          {
	              anishaking_sdev = ds_map_find_value(argument[0], "value");
              
	              break;
	          }
              
	            case "maxframes":
	          {
	              ds_list_add(undo_list,"a"+string(maxframes))
              
	              refresh_minitimeline_flag = 1;
              
	              maxframes = round(ds_map_find_value(argument[0], "value"));
              
	              if (maxframes < 1) 
					maxframes = 1;
	              else if (maxframes > $ffff) 
					maxframes = $ffff;
				
              
	              if (ds_list_size(frame_list) < maxframes)
	                  repeat (maxframes - ds_list_size(frame_list))
	                  {
	                      templist = ds_list_create_pool();
	                      if (fillframes)
	                      {
	                          tempelcount = ds_list_size(ds_list_find_value(frame_list,ds_list_size(frame_list)-1));
	                          for (u = 0;u < tempelcount;u++)
	                          {
	                              tempellist = ds_list_create_pool();
	                              ds_list_copy(tempellist,ds_list_find_value(ds_list_find_value(frame_list,ds_list_size(frame_list)-1),u));
	                              ds_list_add(templist,tempellist);
	                          }
	                      }
	                      ds_list_add(frame_list,templist);
	                  }
	              /*else
	                  repeat (ds_list_size(frame_list)-maxframes)
	                  {
	                      el_list_temp = ds_list_find_value(frame_list,ds_list_size(frame_list)-1);
	                      //for (u = 0;u < ds_list_size(el_list_temp);u++)
	                      //    ds_list_free_pool(ds_list_find_value(el_list_temp,u));
	                      ds_list_free_pool(el_list_temp);
	                  }*/
	              if (frame > maxframes) 
	              {
	                  frame = maxframes-1;
	                  framehr = maxframes-1;
	              }
                  
	              dd_scope_reset(false);
				  clean_redo_list();
              
	              break;
	          }
			  case "maxframes_stretch":
	          { 
				  /*var t_undo_buffer = buffer_create(2, buffer_grow, 1);
				  buffer_write(t_undo_buffer, buffer_string, string(frame_list));
				  var t_compressed_buffer = buffer_compress(t_undo_buffer, 0, buffer_tell(t_undo_buffer));
	              ds_list_add(undo_list,"s"+string(t_compressed_buffer));
				  buffer_delete(t_undo_buffer);*/ //TODO
              
	              refresh_minitimeline_flag = 1;
				  frame_surf_refresh = 1;
				  update_semasterlist_flag = 1;
				  clean_redo_list();
              
	              var t_newmaxframes = round(ds_map_find_value(argument[0], "value"));
              
	              if (t_newmaxframes < 1) 
					t_newmaxframes = 1;
	              else if (t_newmaxframes > $ffff) 
					t_newmaxframes = $ffff;
				
				  var t_newframelist = ds_list_create_pool();
				
				  for (u = 0; u < t_newmaxframes; u++)
				  {
					  var t_newlist = ds_list_create_pool();
					  ds_list_add(t_newframelist, t_newlist);
				  
					  var t_oldlistindex = floor(u * maxframes / t_newmaxframes);
					  var t_oldlist = frame_list[| t_oldlistindex];
					  var t_elcount = ds_list_size(t_oldlist);
					  for (v = 0; v < t_elcount; v++)
					  {
						  var t_newellist = ds_list_create_pool();
						  ds_list_copy(t_newellist, ds_list_find_value(t_oldlist, v));
						  ds_list_add(t_newlist, t_newellist);
					  }
				  }
			  
				  maxframes = t_newmaxframes;
				  frame_list = t_newframelist;
              
	              if (frame > maxframes) 
	              {
	                  frame = maxframes-1;
	                  framehr = maxframes-1;
	              }
                  
	              dd_scope_reset(false);
              
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
	            case ("preset_create"):
	            {
	                var t_newmap = ds_map_create();
	                ds_map_copy(t_newmap, profile_list[| 0]);
	                t_newmap[? "name"] = ds_map_find_value(argument[0], "result");
	                ds_list_add(profile_list, t_newmap);
	                with (obj_profiles)
	                    surface_free(surf_profilelist);
	                break;
	            }
	            case ("preset_rename"):
	            {
	                var t_map = profile_list[| profiletoselect];
	                t_map[? "name"] = ds_map_find_value(argument[0], "result");

	                with (obj_profiles)
	                    surface_free(surf_profilelist);
                    
	                break;
	            }
	            case ("funcx"):
	            {
	                shapefunc_string_x = ds_map_find_value(argument[0], "result");
	                break;
	            }
	            case ("funcy"):
	            {
	                shapefunc_string_y = ds_map_find_value(argument[0], "result");
	                break;
	            }
	            case ("func1"):
	            {
	                colorfunc_string_1 = ds_map_find_value(argument[0], "result");
	                break;
	            }
	            case ("func2"):
	            {
	                colorfunc_string_2 = ds_map_find_value(argument[0], "result");
	                break;
	            }
	            case ("func3"):
	            {
	                colorfunc_string_3 = ds_map_find_value(argument[0], "result");
	                break;
	            }
	            case ("funcen"):
	            {
	                blankfunc_string = ds_map_find_value(argument[0], "result");
	                break;
	            }
	            case ("text"):
	            {
	                text = ds_map_find_value(argument[0], "result");

	                for (i = 0;i <= maxframes;i++)
	                    xdelta[i] = 0;
                
	                //start making elements
	                for (texti = 1; texti <= string_length(text);texti++)
	                {
	                    letter = string_char_at(text,texti);
	                    if (ord(letter) <= $20)
	                    {
	                        for (i = 0;i <= maxframes;i++)
	                            xdelta[i] += font_size/1.3*256*font_spacing;
	                    }
	                    else
	                    {
	                        create_element();
	                    }
	                }
                    
	                frame_surf_refresh = 1;
	                break;
	            }
	            case ("exporthtml5"):
	            {
	                file_loc = ds_map_find_value(argument[0], "result");
	                export_ilda_html5();
	                break;
	            }
	            case ("saveframes"):
	            {
	                file_loc = ds_map_find_value(argument[0], "result");
	                save_frames_html5();
	                break;
	            }
	            case ("serial"):
	            {
	                serial = ds_map_find_value(argument[0], "result");
					if (os_type != os_linux)
						controller.serialfile = file_text_open_write("serial");
					else
						controller.serialfile = file_text_open_write(game_save_id + "serial");
	                file_text_write_string(controller.serialfile,string_lettersdigits(controller.serial));
	                file_text_close(controller.serialfile);
	                verify_serial(true);
	                break;
	            }
	            case ("dacname"):
	            {
	                if (dacwrapper_setname(dac[| 0],ds_map_find_value(argument[0], "result")) == 0)
	                    show_message_new("Error: Could not set name. (Only Helios DACs support naming)");
	                else
	                {
	                    dac[| 1] = ds_map_find_value(argument[0], "result");
	                }
	                break;
	            }
	        }
	      }
	  }
	}
    
	update_colors();
	update_anicolors();



}
