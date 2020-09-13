/// @description _ML_LiP_GetErrorFlags(index)
/// @function _ML_LiP_GetErrorFlags
/// @param index
/// @argType    r
/// @returnType real
/// @hidden     true
function _ML_LiP_GetErrorFlags(argument0) {
	return ds_list_find_value(argument0, ML_LIP_ERRFLAGS);



}
