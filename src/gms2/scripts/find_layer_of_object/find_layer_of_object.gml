// find layer list of object on the timeline
function find_layer_of_object(argument0) {
	for (var t_i = 0; t_i < ds_list_size(seqcontrol.layer_list); t_i++)
	{
		var t_layer = ds_list_find_value(seqcontrol.layer_list[| t_i], 1);
		for (var t_j = 0; t_j < ds_list_size(t_layer); t_j++)
		{
			if (t_layer[| t_j] == argument0)
				return seqcontrol.layer_list[| t_i];
		}
	}
	return -1;


}
