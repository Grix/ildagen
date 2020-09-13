/// @description ML_VM_GetVarReal(parser, key)
/// @function ML_VM_GetVarReal
/// @param parser
/// @param  key
/// @argType    r, s
/// @returnType real
/// @hidden     false
function ML_VM_GetVarReal(argument0, argument1) {
	/*
	**  Usage:
	**      ML_VM_GetVarReal(parser, key)
	**
	**  Arguments:
	**      parser  parser index
	**      key     Key/Pointer to the variable
	**
	**  Returns:
	**      Value of variable at "key"
	**
	**  Notes:
	*/

	var VARMAP =  _ML_LiP_GetVarMap(argument0);
	return real(ds_map_find_value(VARMAP, argument1));



}
