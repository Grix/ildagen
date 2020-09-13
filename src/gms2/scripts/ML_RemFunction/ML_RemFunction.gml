/// @description ML_RemFunction(parser, index)
/// @function ML_RemFunction
/// @param parser
/// @param  index
/// @argType    r,r
/// @returnType void
/// @hidden     false
function ML_RemFunction(argument0, argument1) {
	var P_FUNCTION  = _ML_LiP_GetFunctionTable(argument0);
	ds_map_delete(P_FUNCTION, _ML_Li_GetName(argument1));
	_ML_LiF_Destroy(argument1);



}
