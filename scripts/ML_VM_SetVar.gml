///ML_VM_SetVar(parser, key, value)
/// @argType    r ,s, any
/// @returnType void
/// @hidden     false
/*
**  Usage:
**      ML_VM_SetVar(parser, key, value)
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

