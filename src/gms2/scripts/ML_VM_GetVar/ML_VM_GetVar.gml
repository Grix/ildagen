/// @description ML_VM_GetVar(parser, key)
/// @function ML_VM_GetVar
/// @param parser
/// @param  key
/// @argType    r, s
/// @returnType auto
/// @hidden     false
/*
**  Usage:
**      ML_VM_GetVar(parser, key)
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
return ds_map_find_value(VARMAP, argument1);
