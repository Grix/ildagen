///ML_AddFunction(parser, functionstring,scriptid,returntype, [type_arg1, type_arg2 ... type_argN])
/// @argType    r,s,r,s, s ... s
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_AddFunction(parser, functionstring,scriptid,returntype, [type_arg1, type_arg2 ... type_argN])
**
**  Arguments:
**      parser          Parser index
**      functionstring  string used to identify the function
**      scriptid        script-index from the function
**      returntype      type of variable GML_VAL_REAL / GML_VAL_STRING
**      type_argN       type of the Nth argument (GML_VAL_REAL / GML_VAL_STRING)
**
**  Returns:
**      ID to the new "function type" used in further functions
**
**  Notes:
**      script get as argument when executed: {arg1-value, arg2-value ... argN-value}
*/

var o, c, tlist;
tlist = ds_list_create();
c = argument_count - 4;
for (var i = 0; i < c; ++i) {
    ds_list_add(tlist,argument[i+4]);
}
o = ML_AddFunctionArgList(argument[0], argument[1], argument[2], argument[3], tlist);
ds_list_destroy(tlist);
return o;
