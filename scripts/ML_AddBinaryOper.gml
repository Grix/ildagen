///ML_AddBinaryOper(parser, operator, precedence, script, returntype, lhstype, rhstype[, assoc])
/// @argType    r,s,r,r,s,s,s,r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_AddBinaryOper(parser, operator, precedence, script, returntype, lhstype, rhstype[, assoc])
**
**  Arguments:
**      parser      parser index
**      operator    string used to identify the operator
**      precedence  the precendence of the operator
**      script      script id
**      returntype  return type of the operator
**      lhstype     type of left hand side
**      rhstype     type of right hand side
**      assoc       associtivity of operator (default is left/ML_O_LEFTASSOC)
**
**  Returns:
**      ID to the new "operator type" used in further functions
**
**  Notes:
**      script get as argument when executed: {lhs-value, rhs-value}
*/
var o;
var P_BINOPER = _ML_LiP_GetBinOpsTable(argument[0]);
if (ds_map_exists(P_BINOPER,argument[1])) {
    o = ds_map_find_value(P_BINOPER, argument[1]);
    _ML_LiF_AddSig(o, argument[5] +"$" + argument[6], 
                _ML_AddBinarySig(argument[3], argument[4]));
} else {
    var assoc;
    assoc = ML_O_LEFTASSOC;
    if (argument_count > 7) assoc = argument[7];
    o = _ML_NewBinaryOper(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], assoc);
    ds_map_add(P_BINOPER, argument[1], o);
    _ML_OpAddRoots(argument[0], argument[1]);
}
return o;
