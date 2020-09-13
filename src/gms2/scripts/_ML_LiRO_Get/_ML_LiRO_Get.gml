/// @description _ML_LiRO_Get(ind, n);
/// @function _ML_LiRO_Get
/// @param ind
/// @param  n
/// @argType    r,r
/// @returnType auto
/// @hidden     true
function _ML_LiRO_Get(argument0, argument1) {
	return ds_list_find_value(_ML_LiRO_GetAll(argument0), argument1);



}
