/// @description _ML_LiAOp_Create(name, precedence, associativity)
/// @function _ML_LiAOp_Create
/// @param name
/// @param  precedence
/// @param  associativity
/// @argType    s,r,r
/// @returnType real
/// @hidden     true

var l = ds_list_create();
ds_list_add(l, argument0); //str
ds_list_add(l, ds_map_create()); //actual underlying
ds_list_add(l, argument1); //precedence
ds_list_add(l, argument2); //associativity

return l;
