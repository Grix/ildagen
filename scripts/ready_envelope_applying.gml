///ready_envelope_applying(envelope_list)

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
    
    //binary search algo, set t_index to the current cursor pos
    var imin = 0;
    var imax = ds_list_size(time_list)-1;
    var imid;
    while (imin <= imax)
    {
        imid = floor(mean(imin,imax));
        if (ds_list_find_value(time_list,imid) <= correctframe)
        {
            var valnext = ds_list_find_value(time_list,imid+1);
            if (is_undefined(valnext)) or (valnext >= correctframe)
                break;
            else
                imin = imid+1;
        }
        else
            imax = imid-1;
    }
    var t_index = imid;
    
    //interpolate
    if (t_index == ds_list_size(data_list)-1) or ( (t_index == 0) and (ds_list_find_value(time_list,t_index) >= correctframe) ) or (time_list[| t_index+1] == time_list[| t_index])
        raw_data_value = ds_list_find_value(data_list,t_index);
    else
        raw_data_value = lerp(  ds_list_find_value(data_list,t_index),
                                ds_list_find_value(data_list,t_index+1),
                                1-(ds_list_find_value(time_list,t_index+1)-correctframe)/
                                (ds_list_find_value(time_list,t_index+1)-ds_list_find_value(time_list,t_index)));
        
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
