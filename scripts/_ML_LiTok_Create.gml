///_ML_LiTok_Create( string, pos)
/// @argType    r,r
/// @returnType real
/// @hidden     true
var l = ds_list_create();
ds_list_add(l, ML_TT_UNKNOWN); //type
ds_list_add(l, argument0); //string
ds_list_add(l, argument1); //pos
ds_list_add(l, -1); //operator
ds_list_add(l, 0); //argc
return l;

//operator is a link to function/variable index:
//special for value - is then ML_VAL_REAL/ML_VAL_STRING
//ternary2 also has NOONE

//string is actual value for "ML_TT_VALUE", otherwise just debug string
