/// @description _ML_LiTok_SetArgcount(index, argc)
/// @function _ML_LiTok_SetArgcount
/// @param index
/// @param  argc
/// @argType    r,r
/// @returnType void
/// @hidden     true
function _ML_LiTok_SetArgcount(argument0, argument1) {
	ds_list_replace(argument0, ML_LITOK_ARGC, argument1);



}
