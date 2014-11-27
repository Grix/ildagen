///   _ML_NewTernaryOper(operator1, operator2,precedence,script,returntype, lhstype, mhstype, rhstype, assoc)
/// @argType    s,s,r,r,s,s,s,s,r
/// @returnType r
/// @hidden     true
var ind = _ML_LiTOp_Create(argument0, argument1, argument2, argument8);
_ML_LiF_AddSig(ind, argument5 +"$" + argument6 + "$" +argument7, 
            _ML_AddTernarySig(argument3, argument4));
return ind;
