/// @description output_frame_live(daclist)
/// @function output_frame_live
/// @param daclist
function output_frame_live() {

	output_buffer = controller.dac[| 4];
	output_buffer2 = controller.dac[| 5];
	output_buffer_ready = controller.dac[| 6];
	output_buffer_next_size = controller.dac[| 7];

    
	if (output_buffer_ready)
	{
	    dac_send_frame(controller.dac, output_buffer, output_buffer_next_size, output_buffer_next_size*controller.projectfps/controller.fpsmultiplier);
	    if (!controller.preview_while_laser_on)
			frame_surf_refresh = false;
	    output_buffer_ready = false;
	    controller.laseronfirst = false;
    
	    var t_output_buffer_prev = output_buffer;
	    output_buffer = output_buffer2;
	    output_buffer2 = t_output_buffer_prev;
	}

	maxpoints = 0;
    
	buffer_seek(output_buffer, buffer_seek_start, 0);

	el_list = ds_list_create_pool(); 
    
	var t_exclusive_active = false;
	for (j = 0; j < ds_list_size(filelist); j++)
	{
		if (ds_list_find_value(filelist[| j], 8) != 0)
		{
			t_exclusive_active = true;
			break;
		}
	}
	
	for (j = 0; j < ds_list_size(filelist); j++)
	{
		objectlist = filelist[| j];
	
		if (!objectlist[| 0] || (t_exclusive_active && objectlist[| 8] == 0)) // is not playing
			continue;

		object_maxframes = objectlist[| 4];
		frame = objectlist[| 2];
	
		//modifier transforms
	    ready_envelope_applying_live();

		//draw object
		el_buffer = ds_list_find_value(objectlist,1);
		fetchedframe = frame mod object_maxframes;
		if (!seek_to_correct_frame(el_buffer, fetchedframe, objectlist))
		{
		    controller.dac[| 4] = output_buffer;
		    controller.dac[| 5] = output_buffer2;
		    controller.dac[| 6] = output_buffer_ready;
		    controller.dac[| 7] = output_buffer_next_size;
		    exit;
		}
	
		buffer_maxelements = buffer_read(el_buffer,buffer_u32);
        
		//make into lists
		for (i = 0; i < buffer_maxelements;i++)
		{
		    numofinds = buffer_read(el_buffer,buffer_u32);
		    ind_list = ds_list_create_pool();
		    ds_list_add(el_list,ind_list);
		    for (u = 0; u < 10; u++)
		    {
		        ds_list_add(ind_list,buffer_read(el_buffer,buffer_f32));
		    }
		
			//modifier transforms
	        if (env_rotabs)
	        {
	            var t_actualanchor_x = $8000 - ds_list_find_value(ind_list,0);
	            var t_actualanchor_y = $8000 - ds_list_find_value(ind_list,1);
	        }
	        if (env_xtrans)
	        {
	            ds_list_replace(ind_list,0,ds_list_find_value(ind_list,0) + env_xtrans_val);
	        }
	        if (env_ytrans)
	        {
	            ds_list_replace(ind_list,1,ds_list_find_value(ind_list,1) + env_ytrans_val);
	        }
            
		    for (u = 10; u < 20; u++)
		    {
		        ds_list_add(ind_list,buffer_read(el_buffer,buffer_bool));
		    }
		    for (u = 20; u < numofinds; u += 4)
		    {
		        xp = buffer_read(el_buffer,buffer_f32);
		        yp = buffer_read(el_buffer,buffer_f32);
		        bl = buffer_read(el_buffer,buffer_bool);
		        c = buffer_read(el_buffer,buffer_u32);
			
				//apply modifier transforms to point data
	            if (env_hue)
	            {
	                c = make_colour_hsv((colour_get_hue(c)+env_hue_val) % 255,colour_get_saturation(c),colour_get_value(c));
	            }
	            if (env_a)
	            {
	                c = merge_colour(c,c_black,env_a_val);
	            }
	            if (env_r)
	            {
	                c = (c & $FFFF00) | ((c & $FF)*env_r_val);
	            }
	            if (env_g)
	            {
	                c = (c & $FF00FF) | ((((c >> 8) & $FF)*env_g_val) << 8);
	            }
	            if (env_b)
	            {
	                c = (c & $00FFFF) | (((c >> 16)*env_b_val) << 16);
	            }
	            if (env_rotabs)
	            {
	                angle = degtorad(point_direction(t_actualanchor_x, t_actualanchor_y, xp, yp));
	                dist = point_distance(t_actualanchor_x, t_actualanchor_y, xp, yp);
	                xp = t_actualanchor_x+cos(env_rotabs_val-angle)*dist;
	                yp = t_actualanchor_y+sin(env_rotabs_val-angle)*dist;
	            }
			
		        ds_list_add(ind_list,xp);
		        ds_list_add(ind_list,yp);
		        ds_list_add(ind_list,bl);
		        ds_list_add(ind_list,c);
		    }
		}
	}
    
	//blindzones preview
	if (room = rm_options)
	{
	    blindzone_el_lists = 0;
	    for (i = 0; i < ds_list_size(controller.blindzone_list); i += 4)
	    {
	        var blindzone_el = ds_list_create_pool();
	        blindzone_el[| 19] = 0; //fills up to 19 with 0
	        blindzone_el[| 10] = true;
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
	        ds_list_add(blindzone_el, 0);
	        ds_list_add(blindzone_el, c_white);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
	        ds_list_add(blindzone_el, 0);
	        ds_list_add(blindzone_el, c_white);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 1]);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
	        ds_list_add(blindzone_el, 0);
	        ds_list_add(blindzone_el, c_white);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 3]);
	        ds_list_add(blindzone_el, 0);
	        ds_list_add(blindzone_el, c_white);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 0]);
	        ds_list_add(blindzone_el, controller.blindzone_list[| i + 2]);
	        ds_list_add(blindzone_el, 0);
	        ds_list_add(blindzone_el, c_white);
	        ds_list_add(el_list, blindzone_el);
	        blindzone_el_lists++;
	    }
	}

	assemble_frame_dac();

	if (room == rm_options)
	{
	    for (i = 0; i < blindzone_el_lists; i++)
	    {
	        ds_list_free_pool(el_list[| ds_list_size(el_list)-1]);
	        ds_list_delete(el_list, ds_list_size(el_list)-1);
	    }
	}

	//cleanup
	for (i = 0; i < ds_list_size(el_list); i++)
	{
	    ds_list_free_pool(ds_list_find_value(el_list,i));
	}
	ds_list_free_pool(el_list); el_list = -1;

	output_buffer_ready = true;
	controller.dac[| 4] = output_buffer;
	controller.dac[| 5] = output_buffer2;
	controller.dac[| 6] = output_buffer_ready;
	controller.dac[| 7] = output_buffer_next_size;


}
