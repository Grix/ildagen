/// @description _ML_LiRO_Clear(ind);
/// @function _ML_LiRO_Clear
/// @param ind
/// @argType    r
/// @returnType void
/// @hidden     true
function _ML_LiRO_Clear(argument0) {
	ds_list_clear(_ML_LiRO_GetAll(argument0));
	ds_list_clear(_ML_LiRO_GetAllType(argument0));
	_ML_LiRO_SetFinal(argument0, 0);



}
