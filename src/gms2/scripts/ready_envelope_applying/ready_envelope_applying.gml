/// @description ready_envelope_applying(envelope_list)
/// @function ready_envelope_applying
/// @param envelope_list
function ready_envelope_applying(argument0) {

	env_xtrans = 0;
	env_ytrans = 0;
	env_size = 0;
	env_rotabs = 0;
	env_a = 0;
	env_hue = 0;
	env_r = 0;
	env_g = 0;
	env_b = 0;

	var t_envelope_list = argument0;
	for (u = 0; u < ds_list_size(t_envelope_list); u++)
	{
	    envelope = ds_list_find_value(t_envelope_list,u);
	    disabled = ds_list_find_value(envelope,3);
	    time_list = ds_list_find_value(envelope,1);
    
	    if (ds_list_empty(time_list)) or (disabled)
	        continue;
        
	    data_list = ds_list_find_value(envelope,2); 
    
	    raw_data_value = find_envelope_value(data_list, time_list, correctframe);
    
	    //get value    
	    type = ds_list_find_value(envelope,0);
	    if (type == "x")
	    {
	        env_xtrans = 1;
	        env_xtrans_val = -(raw_data_value-32)*1024;
	    }
	    else if (type == "y")
	    {
	        env_ytrans = 1;
	        env_ytrans_val = -(raw_data_value-32)*1024;
	    }
	    else if (type == "size")
	    {
	        env_size = 1;
	        env_size_val = raw_data_value/32;
	    }
	    else if (type == "rotabs")
	    {
	        env_rotabs = 1;
	        env_rotabs_val = (raw_data_value-32)/64*pi*2;
	    }
	    else if (type == "a")
	    {
	        env_a = 1;
	        env_a_val = raw_data_value/64;
	    }
	    else if (type == "hue")
	    {
	        env_hue = 1;
	        env_hue_val = (raw_data_value-32)/64*255;
	    }
	    else if (type == "r")
	    {
	        env_r = 1;
	        env_r_val = 1-raw_data_value/64;
	    }
	    else if (type == "g")
	    {
	        env_g = 1;
	        env_g_val = 1-raw_data_value/64;
	    }
	    else if (type == "b")
	    {
	        env_b = 1;
	        env_b_val = 1-raw_data_value/64;
	    }
	}



}
