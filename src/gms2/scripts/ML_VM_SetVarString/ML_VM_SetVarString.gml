/// @description ML_VM_SetVarString(parser, key, value)
/// @function ML_VM_SetVarString
/// @param parser
/// @param  key
/// @param  value
/// @argType    r ,s, s
/// @returnType void
/// @hidden     false
/*
**  Usage:
**      ML_VM_SetVarString(parser, key, value)
**
**  Arguments:
**      parser  parser index
**      key     Key/Pointer to the variable
**      value   Value to set
**
**  Returns:
**
**  Notes:
*/
var key, value;
key = argument1;
value = argument2;
var VARMAP = _ML_LiP_GetVarMap(argument0);
VARMAP[? key] = value;
