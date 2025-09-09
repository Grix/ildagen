// find layer list of object on the timeline
function find_layer_of_object(argument0) {
	for (var t_i = 0; t_i < ds_list_size(seqcontrol.layer_list); t_i++)
	{
		var t_layer_objects = ds_list_find_value(seqcontrol.layer_list[| t_i], 1);
		for (var t_j = 0; t_j < ds_list_size(t_layer_objects); t_j++)
		{
			if (t_layer_objects[| t_j] == argument0)
				return seqcontrol.layer_list[| t_i];
		}
		var t_layer_events = ds_list_find_value(seqcontrol.layer_list[| t_i], 10);
		for (var t_j = 0; t_j < ds_list_size(t_layer_events); t_j++)
		{
			if (t_layer_events[| t_j] == argument0)
				return seqcontrol.layer_list[| t_i];
		}
	}
	return -1;


}
