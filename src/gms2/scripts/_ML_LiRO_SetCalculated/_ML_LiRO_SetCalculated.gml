/// @description _ML_LiRO_SetCalculated(index, calc)
/// @function _ML_LiRO_SetCalculated
/// @param index
/// @param  calc
/// @argType    r, any
/// @returnType void
/// @hidden     true
function _ML_LiRO_SetCalculated(argument0, argument1) {
	ds_list_replace(argument0, ML_LIRO_CALCULATED, argument1);



}
