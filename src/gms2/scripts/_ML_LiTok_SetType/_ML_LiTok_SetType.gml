/// @description _ML_LiTok_SetType(index, type)
/// @function _ML_LiTok_SetType
/// @param index
/// @param  type
/// @argType    r,r
/// @returnType void
/// @hidden     true
function _ML_LiTok_SetType(argument0, argument1) {
	ds_list_replace(argument0, ML_LITOK_TYPE, argument1);



}
