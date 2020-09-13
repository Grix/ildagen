/// @description ML_RemVariableStr(parser, VarString) 
/// @function ML_RemVariableStr
/// @param parser
/// @param  VarString
/// @argType    r,s
/// @returnType void
/// @hidden     false
function ML_RemVariableStr(argument0, argument1) {
	//destroys variable - DOES NOT DESTROY IN MAP WITH VALUES


	var P_VARIABLE  = _ML_LiP_GetVariableTable(argument0);
	ML_RemVariable(argument0, ds_map_find_value(P_VARIABLE,argument1));



}
