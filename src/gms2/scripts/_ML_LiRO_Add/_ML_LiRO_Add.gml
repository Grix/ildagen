/// @description _ML_LiRO_Add(ind, answer, type)
/// @function _ML_LiRO_Add
/// @param ind
/// @param  answer
/// @param  type
/// @argType    r,a,s
/// @returnType void
/// @hidden     true
function _ML_LiRO_Add(argument0, argument1, argument2) {
	ds_list_add(_ML_LiRO_GetAll(argument0), argument1);
	ds_list_add(_ML_LiRO_GetAllType(argument0), argument2);



}
