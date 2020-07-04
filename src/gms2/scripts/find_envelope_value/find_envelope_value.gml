///arg0 = value_list, arg1 = time_list, arg2 == frame

var t_index = find_envelope_index(argument1, argument2);
    
if (t_index >= ds_list_size(argument0))
	t_index = ds_list_size(argument0) - 1;
if (t_index < 0)
	t_index = 0;
	
if (t_index == ds_list_size(argument0)-1) or ( (t_index == 0) and (argument1[| t_index] >= argument2) ) or (argument1[| t_index+1] == argument1[| t_index])
	return argument0[| t_index];
else
	return lerp(argument0[| t_index],
				argument0[| t_index+1],
				1-(argument1[| t_index+1]-argument2)/(argument1[| t_index+1]-argument1[| t_index]));