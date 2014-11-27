///ML_RemFunctionStr(parser, function_string)
/// @argType    r,s
/// @returnType void
/// @hidden     false
var P_FUNCTION  = _ML_LiP_GetFunctionTable(argument0);
ML_RemFunction(argument0, ds_map_find_value(P_FUNCTION,argument1));

