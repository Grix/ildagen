/// @description _ML_LiP_SetErrorFlags(index, flag)
/// @function _ML_LiP_SetErrorFlags
/// @param index
/// @param  flag
/// @argType    r, r
/// @returnType void
/// @hidden     true
function _ML_LiP_SetErrorFlags(argument0, argument1) {
	ds_list_replace(argument0, ML_LIP_ERRFLAGS, argument1);



}
