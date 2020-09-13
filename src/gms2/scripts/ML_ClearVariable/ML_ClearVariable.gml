/// @description ML_ClearVariable(parser) 
/// @function ML_ClearVariable
/// @param parser
/// @argType    r
/// @returnType void
/// @hidden     false
function ML_ClearVariable(argument0) {
	//Clears all variables - DOES NOT CLEAR MAP WITH VALUES
	var P_VARIABLE  = _ML_LiP_GetVariableTable(argument0);
	repeat (ds_map_size(P_VARIABLE)) {
	    ML_RemVariableStr(argument0, ds_map_find_first(P_VARIABLE));
	}



}
