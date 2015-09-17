///ML_AddUnaryOper(parser, operator, precedence,script,returntype, valtype,[ affix])
/// @argType    r,s,r,r,s,s,r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_AddUnaryOper(parser, operator, precedence,script,returntype, valtype,[ affix])
**
**  Arguments:
**      parser      parser index
**      operator    string used to identify the operator
**      precedence  precedence
**      script      script id
**      returntype  return type of the operator
**      valtype     type of argument
**      affix       affix of operator (default is prefix/ML_UO_PREFIX)
**
**  Returns:
**      ID to the new "operator type" used in further functions
**
**  Notes:
**      script get as argument when executed: {operand-value}
*/

var o;

var P_UNOPER = _ML_LiP_GetUnOpsTable(argument[0]);
if (ds_map_exists(P_UNOPER,argument[1])) {
    o = ds_map_find_value(P_UNOPER, argument[1]);
    _ML_LiF_AddSig(o, argument[5],_ML_AddUnarySig(argument[3], argument[4]));
} else {
    var affix;
    affix = ML_UO_PREFIX;
    if (argument_count > 6) affix = argument[6];
    o = _ML_NewUnaryOper(argument[1], argument[2], argument[3], argument[4], argument[5], affix);
    ds_map_add(P_UNOPER, argument[1], o);
    _ML_OpAddRoots(argument[0], argument[1]);
}
return o;
