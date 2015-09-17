///ML_AddTernaryOper(parser, operator1, operator2, precedence, script, returntype, lhstype, mhstype, rhstype[, assoc])
/// @argType    r,s,s,r,r,s,s,s,s,r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_AddTernaryOper(parser, operator1, operator2, precedence, script, returntype, lhstype, mhstype, rhstype[, assoc])
**
**  Arguments:
**      parser      parser index
**      operator1   string used to identify the first part of ternary operator
**      operator2   string used to identify the second part of ternary operator
**      precedence  the precendence of the operator
**      script      script id
**      returntype  return type of the operator
**      lhstype     type of left hand side
**      mhstype     type of middle hand side
**      rhstype     type of right hand side
**      assoc       associtivity of operator (default is right/ML_O_RIGHTASSOC)
**
**  Returns:
**      ID to the new "operator type" used in further functions
**      script get as argument when executed: {lhs-value, mhs-value, rhs-value}
**
**  Notes:
**      First operator must be unique
*/

var o;

var P_TERNOPER = _ML_LiP_GetTernOpsTable(argument[0]);
if (ds_map_exists(P_TERNOPER,argument[1])) {
    o = ds_map_find_value(P_TERNOPER, argument[1]);
    _ML_LiF_AddSig(o, argument[6] + "$" + argument[7] + "$" + argument[8], 
                    _ML_AddTernarySig(argument[4], argument[5]));
} else {
    var assoc;
    assoc = ML_O_RIGHTASSOC;
    if (argument_count > 9) assoc = argument[9];
    o = _ML_NewTernaryOper(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], assoc);
    ds_map_add(P_TERNOPER, argument[1], o);
    _ML_OpAddRoots(argument[0], argument[1]);
    _ML_OpAddRoots(argument[0], argument[2]);
    _ML_TernaryAddSecond(argument[0], argument[2],o);
}
return o;
