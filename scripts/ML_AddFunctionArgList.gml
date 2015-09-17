///ML_AddFunctionArgList(parser, functionstring,scriptid,returntype, argtypelist)
/// @argType    r,s,r,s,r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_AddFunction(parser, functionstring,scriptid,returntype, argtypelist)
**
**  Arguments:
**      parser          Parser index
**      functionstring  string used to identify the function
**      scriptid        script-index from the function
**      returntype      type of variable GML_VAL_REAL / GML_VAL_STRING
**      argtypelist     type of the arguments (GML_VAL_REAL / GML_VAL_STRING)
**
**  Returns:
**      ID to the new "function type" used in further functions
**
**  Notes:
**      script get as argument when executed: {arg1-value, arg2-value ... argN-value}
*/

var o, tlist;
tlist = argument4;
var P_FUNCTION  = _ML_LiP_GetFunctionTable(argument0);

if (ds_map_exists(P_FUNCTION,argument1)) {
    var argstr = "";
    c = ds_list_size(tlist);
    if (c > 0) {
        argstr = ds_list_find_value(tlist, 1);
        for (var i = 1; i < c; ++i) {
            argstr += "$" + ds_list_find_value(tlist, i);
        }
    }
    o = ds_map_find_value(P_FUNCTION, argument1);
    _ML_LiF_AddSig(o, argstr, _ML_AddFunctionSig(argument2, argument3));
} else {
    o = _ML_NewFunction(argument1, argument2, argument3, tlist);
    ds_map_add(P_FUNCTION, argument1, o);
}

return o;
