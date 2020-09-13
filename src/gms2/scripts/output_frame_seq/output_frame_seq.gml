/// @description output_frame_seq(daclist)
/// @function output_frame_seq
/// @param daclist
function output_frame_seq() {

	var t_dac = argument[0];
	var t_dac_index = ds_list_find_index(controller.dac_list, t_dac);
	if (t_dac_index == -1)
	    exit;
	
	minroomspeed = max(projectfps,7.5);
    
	output_buffer = t_dac[| 4];
	output_buffer2 = t_dac[| 5];
	output_buffer_ready = t_dac[| 6];
	output_buffer_next_size = t_dac[| 7];

    
	if (output_buffer_ready)
	{
	    dac_send_frame(t_dac, output_buffer, output_buffer_next_size, output_buffer_next_size*projectfps/controller.fpsmultiplier);
	    if (!controller.preview_while_laser_on)
			frame_surf_refresh = false;
	    output_buffer_ready = false;
	    controller.laseronfirst = false;
    
	    var t_output_buffer_prev = output_buffer;
	    output_buffer = output_buffer2;
	    output_buffer2 = t_output_buffer_prev;
	}

	maxpoints = 0;

	if (!playing)
	    correctframe = round(tlpos/1000*projectfps);
	else
	    correctframe = round(tlpos/1000*projectfps)+1;
    
	buffer_seek(output_buffer, buffer_seek_start, 0);

	el_list = ds_list_create(); 
	//check which should be drawn
	for (k = 0; k < ds_list_size(layer_list); k++)
	{
		if (ds_list_find_value(layer_list[| k], 2)) // if muted
			continue;
	
	    var t_found = false;
	    var t_daclist = ds_list_find_value(layer_list[| k], 5);
	    if (ds_list_size(t_daclist) == 0)
	    {
	        if (ds_list_exists(controller.dac))
	            t_found = true;
	    }
	    for (m = 0; m < ds_list_size(t_daclist); m++)
	    {
	        var t_thisdac = t_daclist[| m];
	        if (t_thisdac[| 0] == t_dac_index)
	            t_found = true;
	    }
    
	    if (t_found == false)
	        continue;
    
	    env_dataset = 0;
	    _layer = ds_list_find_value(layer_list[| k], 1);
	
	    for (m = 0; m < ds_list_size(_layer); m++)
	    {
	        objectlist = ds_list_find_value(_layer,m);
		
			if (!ds_list_exists(objectlist))
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
        
			if (!seek_to_correct_frame(el_buffer, fetchedframe, objectlist))
			{
				t_dac[| 4] = output_buffer;
	            t_dac[| 5] = output_buffer2;
	            t_dac[| 6] = output_buffer_ready;
	            t_dac[| 7] = output_buffer_next_size;
	            exit;
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
	                //apply envelope transforms to point data
	                if (env_hue)
	                {
	                    c = make_colour_hsv((colour_get_hue(c)+env_hue_val+255) % 255,colour_get_saturation(c),colour_get_value(c));
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
	}

	if (t_dac[| 2] == -1)
	    load_profile_temp(controller.projector);
	else
	    load_profile_temp(t_dac[| 2]);
    
	//blindzones preview
	if (room = rm_options)
	{
	    blindzone_el_lists = 0;
	    for (i = 0; i < ds_list_size(controller.blindzone_list); i += 4)
	    {
	        var blindzone_el = ds_list_create();
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

	if (room = rm_options)
	{
	    for (i = 0; i < blindzone_el_lists; i++)
	    {
	        ds_list_destroy(el_list[| ds_list_size(el_list)-1]);
	        ds_list_delete(el_list, ds_list_size(el_list)-1);
	    }
	}

	//cleanup
	for (i = 0;i < ds_list_size(el_list);i++)
	{
	    ds_list_destroy(ds_list_find_value(el_list,i));
	}
	ds_list_destroy(el_list);

	output_buffer_ready = true;

	t_dac[| 4] = output_buffer;
	t_dac[| 5] = output_buffer2;
	t_dac[| 6] = output_buffer_ready;
	t_dac[| 7] = output_buffer_next_size;





}
