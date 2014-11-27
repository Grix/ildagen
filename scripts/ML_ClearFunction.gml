///ML_ClearFunction(parser)
/// @argType    r
/// @returnType void
/// @hidden     false
var P_FUNCTION  = _ML_LiP_GetFunctionTable(argument0);
repeat (ds_map_size(P_FUNCTION)) {
    ML_RemFunctionStr(argument0, ds_map_find_first(P_FUNCTION));
}
