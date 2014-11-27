///ML_ClearAssignOper(parser)
/// @argType    r
/// @returnType void
/// @hidden     false
var P_ASSIGNOPER = _ML_LiP_GetAssignOpsTable(argument0);
repeat (ds_map_size(P_ASSIGNOPER)) {
    ML_RemAssignOperStr(argument0, ds_map_find_first(P_ASSIGNOPER));
}
