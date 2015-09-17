///ML_ClearUnaryOper(parser)
/// @argType    r
/// @returnType void
/// @hidden     false
var P_UNOPER = _ML_LiP_GetUnOpsTable(argument0);
repeat (ds_map_size(P_UNOPER)) {
    ML_RemUnaryOperStr(argument0, ds_map_find_first(P_UNOPER));
}
