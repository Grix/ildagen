/// @description _ML_LiS_Create(script, rettype);
/// @function _ML_LiS_Create
/// @param script
/// @param  rettype
/// @argType    r,s
/// @returnType real
/// @hidden     true
function _ML_LiS_Create(argument0, argument1) {
	var l = ds_list_create();
	ds_list_add(l, argument0); //script
	ds_list_add(l, argument1); //return type

	return l;



}
