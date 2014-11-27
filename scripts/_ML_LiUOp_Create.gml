///_ML_LiUOp_Create(name, precedence, associativity, affix)
/// @argType    s,r,r,r
/// @returnType real
/// @hidden     true

var l = ds_list_create();
ds_list_add(l, argument0); //str
ds_list_add(l, ds_map_create()); //actual underlying
ds_list_add(l, argument1); //precedence
ds_list_add(l, argument2); //associativity
ds_list_add(l, argument3); //affix


return l;

