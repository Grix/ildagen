/// @description _ML_LiBOp_Create(name, precedence, associativity)
/// @function _ML_LiBOp_Create
/// @param name
/// @param  precedence
/// @param  associativity
/// @argType    s,r,r
/// @returnType real
/// @hidden     true
function _ML_LiBOp_Create(argument0, argument1, argument2) {

	var l = ds_list_create();
	ds_list_add(l, argument0); //str
	ds_list_add(l, ds_map_create()); //actual underlying
	ds_list_add(l, argument1); //precedence
	ds_list_add(l, argument2); //associativity

	return l;



}
