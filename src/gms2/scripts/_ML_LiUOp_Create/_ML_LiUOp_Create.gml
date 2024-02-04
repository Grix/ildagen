/// @description _ML_LiUOp_Create(name, precedence, associativity, affix)
/// @function _ML_LiUOp_Create
/// @param name
/// @param  precedence
/// @param  associativity
/// @param  affix
/// @argType    s,r,r,r
/// @returnType real
/// @hidden     true
function _ML_LiUOp_Create(argument0, argument1, argument2, argument3) {

	var l = ds_list_create_pool();
	ds_list_add(l, argument0); //str
	ds_list_add(l, ds_map_create()); //actual underlying
	ds_list_add(l, argument1); //precedence
	ds_list_add(l, argument2); //associativity
	ds_list_add(l, argument3); //affix


	return l;



}
