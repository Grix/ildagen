/// @description ML_ClearAssignOper(parser)
/// @function ML_ClearAssignOper
/// @param parser
/// @argType    r
/// @returnType void
/// @hidden     false
function ML_ClearAssignOper(argument0) {
	var P_ASSIGNOPER = _ML_LiP_GetAssignOpsTable(argument0);
	repeat (ds_map_size(P_ASSIGNOPER)) {
	    ML_RemAssignOperStr(argument0, ds_map_find_first(P_ASSIGNOPER));
	}



}
