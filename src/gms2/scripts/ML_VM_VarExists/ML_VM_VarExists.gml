/// @description  ML_VM_VarExists(parser, varstring)
/// @function  ML_VM_VarExists
/// @param parser
/// @param  varstring
/// @argType    r, s
/// @returnType real
/// @hidden     false

var VARMAP =  ML_VM_Get(argument0);
return ds_map_exists(VARMAP, argument1);
