/// @description ML_ClearFunction(parser)
/// @function ML_ClearFunction
/// @param parser
/// @argType    r
/// @returnType void
/// @hidden     false
function ML_ClearFunction(argument0) {
	var P_FUNCTION  = _ML_LiP_GetFunctionTable(argument0);
	repeat (ds_map_size(P_FUNCTION)) {
	    ML_RemFunctionStr(argument0, ds_map_find_first(P_FUNCTION));
	}



}
