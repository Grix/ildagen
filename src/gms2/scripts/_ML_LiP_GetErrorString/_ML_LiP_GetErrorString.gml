/// @description _ML_LiP_GetErrorString(index)
/// @function _ML_LiP_GetErrorString
/// @param index
/// @argType    r
/// @returnType string
/// @hidden     true
function _ML_LiP_GetErrorString(argument0) {
	return ds_list_find_value(argument0, ML_LIP_ERRSTRING);



}
