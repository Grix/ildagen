/// @description _ML_LiVar_Create(string, type, readonly)
/// @function _ML_LiVar_Create
/// @param string
/// @param  type
/// @param  readonly
/// @argType    s, s, r
/// @returnType real
/// @hidden     true
var l = ds_list_create();
ds_list_add(l, argument0); //str
ds_list_add(l, argument2); //readonly
ds_list_add(l, argument1); //type
return l;
