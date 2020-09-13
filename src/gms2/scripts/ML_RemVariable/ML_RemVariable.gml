/// @description ML_RemVariable(parser, index) destroys variable - DOES NOT DESTROY IN MAP WITH VALUES
/// @function ML_RemVariable
/// @param parser
/// @param  index
/// @argType    r,r
/// @returnType void
/// @hidden     false
function ML_RemVariable(argument0, argument1) {

	var P_VARIABLE  = _ML_LiP_GetVariableTable(argument0);
	ds_map_delete(P_VARIABLE, _ML_Li_GetName(argument1));
	_ML_LiVar_Destroy(argument1);



}
