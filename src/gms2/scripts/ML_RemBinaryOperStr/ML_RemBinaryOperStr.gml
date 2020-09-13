/// @description ML_RemBinaryOperStr(parser, Binary operator string)
/// @function ML_RemBinaryOperStr
/// @param parser
/// @param  Binary operator string
/// @argType    r,s
/// @returnType void
/// @hidden     false
function ML_RemBinaryOperStr(argument0, argument1) {

	var P_BINOPER = _ML_LiP_GetBinOpsTable(argument0);
	ML_RemBinaryOper(argument0, ds_map_find_value(P_BINOPER,argument1));



}
