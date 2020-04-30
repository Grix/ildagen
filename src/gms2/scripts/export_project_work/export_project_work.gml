for (j = global.loading_current; j < global.loading_end;j++)
{
        
    correctframe = j;
    framepost = j-startframe;
    framea[0] = framepost & 255;
    framepost = framepost >> 8;
    framea[1] = framepost & 255; 
    buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
    buffer_write(ilda_buffer,buffer_u8,$4C);
    buffer_write(ilda_buffer,buffer_u8,$44);
    buffer_write(ilda_buffer,buffer_u8,$41);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,controller.exp_format);
    buffer_write(ilda_buffer,buffer_u8,ord("L")); //name
    buffer_write(ilda_buffer,buffer_u8,ord("S"));
    buffer_write(ilda_buffer,buffer_u8,ord("G"));
    buffer_write(ilda_buffer,buffer_u8,ord("e"));
    buffer_write(ilda_buffer,buffer_u8,ord("n"));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord("G")); //author
    buffer_write(ilda_buffer,buffer_u8,ord("i"));
    buffer_write(ilda_buffer,buffer_u8,ord("t"));
    buffer_write(ilda_buffer,buffer_u8,ord("l"));
    buffer_write(ilda_buffer,buffer_u8,ord("e"));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    buffer_write(ilda_buffer,buffer_u8,ord("M"));
    buffer_write(ilda_buffer,buffer_u8,ord(" "));
    maxpointspos = buffer_tell(ilda_buffer);
    buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
    buffer_write(ilda_buffer,buffer_u8,framea[1]); //frame
    buffer_write(ilda_buffer,buffer_u8,framea[0]); //frame
    buffer_write(ilda_buffer,buffer_u8,maxframesa[1]); //maxframes
    buffer_write(ilda_buffer,buffer_u8,maxframesa[0]); 
    buffer_write(ilda_buffer,buffer_u8,0); //scanner
    buffer_write(ilda_buffer,buffer_u8,0); //0
        
    el_list = ds_list_create(); 
    //check which should be drawn
    for (k = 0; k < ds_list_size(layer_list); k++)
    {
        env_dataset = 0;
        
        _layer = ds_list_find_value(layer_list[| k], 1);
        for (m = 0; m < ds_list_size(_layer); m++)
        {
            objectlist = ds_list_find_value(_layer,m);
			if (!ds_exists(objectlist,ds_type_list))
			{
				ds_list_delete(_layer, m);
				if (m > 0)
					m--;
				continue;
			}
            
            infolist =  ds_list_find_value(objectlist,2);
            frametime = round(ds_list_find_value(objectlist,0));
            object_length = ds_list_find_value(infolist,0);
            object_maxframes = ds_list_find_value(infolist,2);
            
            if (correctframe != clamp(correctframe, frametime, frametime+object_length))
                continue;
                
            //envelope transforms
            if (!env_dataset)
            {
                env_dataset = 1;
                
                ready_envelope_applying(ds_list_find_value(layer_list[| k], 0));
            }
            
            //yup, draw object
            el_buffer = ds_list_find_value(objectlist,1);
            fetchedframe = (correctframe-frametime) mod object_maxframes;
            buffer_seek(el_buffer,buffer_seek_start,0);
            buffer_ver = buffer_read(el_buffer,buffer_u8);
            if (buffer_ver != 52)
            {
                show_message_new("Error: Unexpected idbyte in buffer for export_project_work(). Things might get ugly. Contact developer.");
                global.loading_exportproject = 0;
                room_goto(rm_seq);
                exit;
            }
            buffer_maxframes = buffer_read(el_buffer,buffer_u32);
            
            //skip to correct frame
            for (i = 0; i < fetchedframe;i++)
            {
                numofel = buffer_read(el_buffer,buffer_u32);
                for (u = 0; u < numofel; u++)
                {
                    numofdata = buffer_read(el_buffer,buffer_u32)-20;
                    buffer_seek(el_buffer,buffer_seek_relative,50+numofdata*3.25);
                }
            }
                
            buffer_maxelements = buffer_read(el_buffer,buffer_u32);
            
            //make into lists
            for (i = 0; i < buffer_maxelements;i++)
            {
                numofinds = buffer_read(el_buffer,buffer_u32);
                ind_list = ds_list_create();
                ds_list_add(el_list,ind_list);
                for (u = 0; u < 10; u++)
                {
                    ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                }
                //envelope transforms
                if (env_xtrans)
                {
                    ds_list_replace(ind_list,0,ds_list_find_value(ind_list,0) + env_xtrans_val);
                }
                if (env_ytrans)
                {
                    ds_list_replace(ind_list,1,ds_list_find_value(ind_list,1) + env_ytrans_val);
                }
				if (env_rotabs)
	            {
	                var t_actualanchor_x = $8000;//$8000 - ds_list_find_value(ind_list,0); TODO
	                var t_actualanchor_y = $0;//$8000 - ds_list_find_value(ind_list,1);
	            }
                for (u = 10; u < 20; u++)
                {
                    ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
                }
                for (u = 20; u < numofinds; u += 4)
                {
                    ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                    ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
                    ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
                    ds_list_add(ind_list,buffer_read(el_buffer,buffer_u32));
                    //apply envelope transforms to point data
                    if (env_hue)
                    {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_hsv(  (colour_get_hue(c)+env_hue_val) mod 255,
                                                                                            colour_get_saturation(c),
                                                                                            colour_get_value(c)));
                    }
                    if (env_a)
                    {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,merge_colour(c,c_black,env_a_val));
                    }
                    if (env_r)
                    {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  colour_get_red(c)*env_r_val,
                                                                                            colour_get_green(c),
                                                                                            colour_get_blue(c)));
                    }
                    if (env_g)
                    {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  colour_get_red(c),
                                                                                            colour_get_green(c)*env_g_val,
                                                                                            colour_get_blue(c)));
                    }
                    if (env_b)
                    {
                        c = ds_list_find_value(ind_list,ds_list_size(ind_list)-1);
                        ds_list_replace(ind_list,ds_list_size(ind_list)-1,make_colour_rgb(  colour_get_red(c),
                                                                                            colour_get_green(c),
                                                                                            colour_get_blue(c)*env_b_val));
                    }
					if (env_rotabs)
	                {
						var t_xp = ds_list_find_value(ind_list,ds_list_size(ind_list)-4);
						var t_yp = ds_list_find_value(ind_list,ds_list_size(ind_list)-3);
	                    angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, t_xp, t_yp));
	                    dist = point_distance(t_actualanchor_x, t_actualanchor_y, t_xp, t_yp);
						ds_list_replace(ind_list,ds_list_size(ind_list)-4, t_actualanchor_x+cos(env_rotabs_val-angle)*dist);
						ds_list_replace(ind_list,ds_list_size(ind_list)-3, t_actualanchor_y+sin(env_rotabs_val-angle)*dist);
	                }
                }
            }
                    
        }
    }
    
    if (!assemble_frame_ilda())
        continue;
       
    //cleanup
    for (i = 0;i < ds_list_size(el_list);i++)
    {
        ds_list_destroy(ds_list_find_value(el_list,i));
    }
    ds_list_destroy(el_list);
    
    if (get_timer()-global.loadingtimeprev >= 100000)
    {
        j++;
        global.loading_current = j;
        global.loadingtimeprev = get_timer();
        return 0;
    }
}

//null header
buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
buffer_write(ilda_buffer,buffer_u8,$4C);
buffer_write(ilda_buffer,buffer_u8,$44);
buffer_write(ilda_buffer,buffer_u8,$41);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,controller.exp_format);
buffer_write(ilda_buffer,buffer_u8,ord("L")); //name
buffer_write(ilda_buffer,buffer_u8,ord("S"));
buffer_write(ilda_buffer,buffer_u8,ord("G"));
buffer_write(ilda_buffer,buffer_u8,ord("e"));
buffer_write(ilda_buffer,buffer_u8,ord("n"));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord("G")); //author
buffer_write(ilda_buffer,buffer_u8,ord("i"));
buffer_write(ilda_buffer,buffer_u8,ord("t"));
buffer_write(ilda_buffer,buffer_u8,ord("l"));
buffer_write(ilda_buffer,buffer_u8,ord("e"));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u8,ord("M"));
buffer_write(ilda_buffer,buffer_u8,ord(" "));
buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
buffer_write(ilda_buffer,buffer_u16,0); //frame
buffer_write(ilda_buffer,buffer_u16,0); //maxframes
buffer_write(ilda_buffer,buffer_u8,0); //scanner
buffer_write(ilda_buffer,buffer_u8,0); //0

ds_map_destroy(c_map);

//remove excess size
buffer_resize(ilda_buffer,buffer_tell(ilda_buffer));

//export
buffer_save(ilda_buffer,file_loc);

var t_time = get_timer();
while ((get_timer() - t_time) > 4095)
    j = 0;

show_message_new("ILDA file (format "+string(controller.exp_format)+") exported to "+string(file_loc));

global.loading_exportproject = 0;

buffer_delete(ilda_buffer);

room_goto(rm_seq);
