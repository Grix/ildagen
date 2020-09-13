function layer_mute() {
	var t_layer = ds_list_find_value(layer_list,selectedlayer);
	t_layer[| 2] = !t_layer[| 2];
	timeline_surf_length = 0;


}
