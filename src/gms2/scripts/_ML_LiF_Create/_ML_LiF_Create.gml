/// @description _ML_LiF_Create(name)
/// @function _ML_LiF_Create
/// @param name
/// @argType    s
/// @returnType real
/// @hidden     true

var l = ds_list_create();
ds_list_add(l, argument0); //str
ds_list_add(l, ds_map_create()); //actual underlying
return l;
