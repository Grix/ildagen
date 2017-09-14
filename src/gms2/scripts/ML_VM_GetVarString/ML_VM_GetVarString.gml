/// @description ML_VM_GetVarString(parser, key)
/// @function ML_VM_GetVarString
/// @param parser
/// @param  key
/// @argType    r , s
/// @returnType string
/// @hidden     false
/*
**  Usage:
**      ML_VM_GetVarString(parser, key)
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
return string(ds_map_find_value(VARMAP, argument1));
