///_ML_LiTOp_Create(name_P1, name_P2, precedence, associativity)
/// @argType    s,s,r,r
/// @returnType real
/// @hidden     true

var l = ds_list_create();
ds_list_add(l, argument0 + argument1); //fullname
ds_list_add(l, ds_map_create()); //actual underlying
ds_list_add(l, argument2); //precedence
ds_list_add(l, argument3); //associativity
ds_list_add(l, argument0); //str1
ds_list_add(l, argument1); //str2

return l;

