/// @description _ML_LiP_SetVarMap(index, map)
/// @function _ML_LiP_SetVarMap
/// @param index
/// @param  map
/// @argType    r, r
/// @returnType void
/// @hidden     true
function _ML_LiP_SetVarMap(argument0, argument1) {
	ds_list_replace(argument0, ML_LIP_VARMAP, argument1);



}
