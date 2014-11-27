///ML_ClearBinaryOper(parser)
/// @argType    r
/// @returnType void
/// @hidden     false
var P_BINOPER = _ML_LiP_GetBinOpsTable(argument0);
repeat (ds_map_size(P_BINOPER)) {
    ML_RemBinaryOperStr(argument0, ds_map_find_first(P_BINOPER));
}
