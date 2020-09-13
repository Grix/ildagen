/// @description ML_RemUnaryOperStr(parser, Unary operator string)
/// @function ML_RemUnaryOperStr
/// @param parser
/// @param  Unary operator string
/// @argType    r,s
/// @returnType void
/// @hidden     false
function ML_RemUnaryOperStr(argument0, argument1) {
	var P_UNOPER = _ML_LiP_GetUnOpsTable(argument0);
	ML_RemUnaryOper(argument0, ds_map_find_value(P_UNOPER,argument1));



}
