/// @description ML_RemAssignOper(parser, index)
/// @function ML_RemAssignOper
/// @param parser
/// @param  index
/// @argType    r,r
/// @returnType void
/// @hidden     false
function ML_RemAssignOper(argument0, argument1) {
	var P_ASSIGNOPER = _ML_LiP_GetAssignOpsTable(argument0);
	_ML_OpRemRoots(argument0, _ML_Li_GetName(argument1));
	ds_map_delete(P_ASSIGNOPER, _ML_Li_GetName(argument1));
	_ML_LiAOp_Destroy(argument1);



}
