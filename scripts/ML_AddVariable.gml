///ML_AddVariable(parser, varstring,[value, type, readonly = true])
/// @argType    r,s,a,s,r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_AddVariable( parser, varstring,[value, type, readonly = true])
**
**  Arguments:
**      parser      parser index
**      varstring   string used to identify the variable
**      value       initial value, if variable does not exist yet (default 0)
**      type        type of variable ML_VAL_REAL / ML_VAL_STRING - If omitted the variables current state is used
**      readonly    wether or not the value can be written (default to read only)
**
**  Returns:
**      ID to the new "variable type" used in further functions
**
**  Notes:
*/

var VARMAP  = _ML_LiP_GetVarMap(argument[0]);
var str = argument[1];

if (!ds_map_exists(VARMAP,str) ) {
    var tval = 0;
    if (argument_count > 2) {
        tval = argument[2];
    }   
    ds_map_add(VARMAP, str, tval);
}
var type;
if (argument_count > 3) {
    type = argument[3];
} else {
    var t = ds_map_find_value(VARMAP, str);
    if (is_real(t)) {
        type = ML_VAL_REAL;
    } else {
        type = ML_VAL_STRING;
    }
}
var ro = true;
if (argument_count > 4) {
    ro = argument[4];
}

var v = _ML_LiVar_Create(str, type, ro);
ds_map_add(_ML_LiP_GetVariableTable(argument[0]),str,v);
return v;
