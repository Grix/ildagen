///ML_VM_GetVarReal(parser, key)
/// @argType    r, s
/// @returnType real
/// @hidden     false
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
