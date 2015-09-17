/// _ML_NewBinaryOper(operator,precedence,script,returntype, lhstype, rhstype, assoc)
/// @argType    s,r,r,s,s,s,r
/// @returnType r
/// @hidden     true

var ind = _ML_LiBOp_Create(argument0, argument1, argument6);
_ML_LiF_AddSig(ind, argument4 +"$" + argument5, _ML_AddBinarySig(argument2, argument3));
return ind;
