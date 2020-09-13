/// @description _ML_LiP_SetFunctionString(index, string)
/// @function _ML_LiP_SetFunctionString
/// @param index
/// @param  string
/// @argType    r, s
/// @returnType void
/// @hidden     true
function _ML_LiP_SetFunctionString(argument0, argument1) {
	ds_list_replace(argument0, ML_LIP_FUNCSTR, argument1);



}
