function _ML_FSubassign(argument0, argument1, argument2) {
	//subtract assign -=

	var v;
	v = ds_map_find_value(argument0, argument1)-argument2;
	ds_map_replace(argument0, argument1, v);
	return v;



}
