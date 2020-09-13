function _ML_FBSRassign(argument0, argument1, argument2) {
	//bitshift right assign >>=

	var v;
	v = ds_map_find_value(argument0, argument1) >> argument2;
	ds_map_replace(argument0, argument1, v);
	return v;



}
