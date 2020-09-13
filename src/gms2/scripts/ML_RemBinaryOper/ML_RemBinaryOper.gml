/// @description ML_RemBinaryOper(parser, index)
/// @function ML_RemBinaryOper
/// @param parser
/// @param  index
/// @argType    r,r
/// @returnType void
/// @hidden     false
function ML_RemBinaryOper(argument0, argument1) {
	var P_BINOPER = _ML_LiP_GetBinOpsTable(argument0);
	_ML_OpRemRoots(argument0, _ML_Li_GetName(argument1));
	ds_map_delete(P_BINOPER, _ML_Li_GetName(argument1));
	_ML_LiBOp_Destroy(argument1);



}
