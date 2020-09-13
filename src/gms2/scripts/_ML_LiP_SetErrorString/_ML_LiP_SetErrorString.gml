/// @description _ML_LiP_SetErrorString(index, string)
/// @function _ML_LiP_SetErrorString
/// @param index
/// @param  string
/// @argType    r, s
/// @returnType void
/// @hidden     true
function _ML_LiP_SetErrorString(argument0, argument1) {
	ds_list_replace(argument0, ML_LIP_ERRSTRING, argument1);



}
