/// @description _ML_LiVar_GetType(index)
/// @function _ML_LiVar_GetType
/// @param index
/// @argType    r
/// @returnType string
/// @hidden     true
function _ML_LiVar_GetType(argument0) {
	return ds_list_find_value(argument0, ML_LIVAR_TYPE);



}
