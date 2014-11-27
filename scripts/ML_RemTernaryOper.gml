///ML_RemTernaryOper(parser, index);
/// @argType    r,r
/// @returnType void
/// @hidden     false
var ind = argument1;
var P_TERNOPER = _ML_LiP_GetTernOpsTable(argument0);
var P_TERNOPER2 = _ML_LiP_GetTernOps2Table(argument0);

var str1 = _ML_LiTOp_GetFirstName(ind);
var str2 = _ML_LiTOp_GetSecondName(ind);

ds_map_delete(P_TERNOPER, str1);
var entry, i;
entry = ds_map_find_value(P_TERNOPER2, str2);
i = ds_list_find_index(entry, ind);
if (i < 0)  { 
    show_error("Ternary operator removal error", true);
} else {
    ds_list_delete(entry, i);
}
if (ds_list_empty(entry)) {
    ds_list_destroy(entry);
    ds_map_delete(P_TERNOPER2, str2);
}
_ML_OpRemRoots(argument0, str1);
_ML_OpRemRoots(argument0, str2);
_ML_LiTOp_Destroy(ind);

