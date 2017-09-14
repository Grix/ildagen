/// @description ML_RemTernaryOperStr(parser, Ternary operator string)
/// @function ML_RemTernaryOperStr
/// @param parser
/// @param  Ternary operator string
/// @argType    r,s
/// @returnType void
/// @hidden     false
var P_TERNOPER = _ML_LiP_GetTernOpsTable(argument0);
ML_RemTernaryOper(argument0, ds_map_find_value(P_TERNOPER,argument1));
