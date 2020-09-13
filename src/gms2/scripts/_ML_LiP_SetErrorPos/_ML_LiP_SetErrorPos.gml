/// @description _ML_LiP_SetErrorPos(index, position)
/// @function _ML_LiP_SetErrorPos
/// @param index
/// @param  position
/// @argType    r, r
/// @returnType void
/// @hidden     true
function _ML_LiP_SetErrorPos(argument0, argument1) {
	ds_list_replace(argument0, ML_LIP_ERRPOS, argument1);



}
