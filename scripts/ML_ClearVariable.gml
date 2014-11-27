///ML_ClearVariable(parser) 
/// @argType    r
/// @returnType void
/// @hidden     false
//Clears all variables - DOES NOT CLEAR MAP WITH VALUES
var P_VARIABLE  = _ML_LiP_GetVariableTable(argument0);
repeat (ds_map_size(P_VARIABLE)) {
    ML_RemVariableStr(argument0, ds_map_find_first(P_VARIABLE));
}
