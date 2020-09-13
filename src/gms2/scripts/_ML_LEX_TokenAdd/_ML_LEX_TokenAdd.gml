/// @description _ML_LEX_TokenAdd(list, string, position)
/// @function _ML_LEX_TokenAdd
/// @param list
/// @param  string
/// @param  position
/// @argType    r,s,r
/// @returnType r
/// @hidden     true
function _ML_LEX_TokenAdd(argument0, argument1, argument2) {

	var ind = _ML_LiTok_Create(argument1, argument2);
	ds_list_add(argument0, ind);

	return ind;



}
