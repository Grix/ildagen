/// _ML_TernaryAddSecond(parser, oper_2_string, ternary_id)
/// @argType    r,s,r
/// @returnType r
/// @hidden     true
var P_TERNOPER2 = _ML_LiP_GetTernOps2Table(argument0);
var entry;
if (ds_map_exists(P_TERNOPER2,argument1)) {
    entry = ds_map_find_value(P_TERNOPER2, argument1);
} else {
    entry = ds_list_create();
    ds_map_add(P_TERNOPER2, argument1, entry);
}
ds_list_add(entry, argument2);
