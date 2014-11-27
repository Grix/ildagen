///ML_RemAssignOperStr(parser, Assign operator string)
/// @argType    r,s
/// @returnType void
/// @hidden     false
var P_ASSIGNOPER = _ML_LiP_GetAssignOpsTable(argument0);
ML_RemAssignOper(argument0, ds_map_find_value(P_ASSIGNOPER,argument1));

