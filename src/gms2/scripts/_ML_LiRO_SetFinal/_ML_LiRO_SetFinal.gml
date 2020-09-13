/// @description _ML_LiRO_SetFinal(index, answer)
/// @function _ML_LiRO_SetFinal
/// @param index
/// @param  answer
/// @argType    r, any
/// @returnType void
/// @hidden     true
function _ML_LiRO_SetFinal(argument0, argument1) {
	ds_list_replace(argument0, ML_LIRO_ANSWER, argument1);



}
