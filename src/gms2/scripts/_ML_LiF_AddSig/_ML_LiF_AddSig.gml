/// @description _ML_LiF_AddSig(operator_id, argstring, actual_functor)
/// @function _ML_LiF_AddSig
/// @param operator_id
/// @param  argstring
/// @param  actual_functor
function _ML_LiF_AddSig(argument0, argument1, argument2) {
	var ActualFunctions = ds_list_find_value(argument0, ML_LIFUNC_ACTUAL);
	ds_map_add(ActualFunctions, argument1, argument2);



}
