/// @description   _ML_NewAssignOper(operator, precedence, script,returntype, lhstype, rhstype, assoc)
/// @function   _ML_NewAssignOper
/// @param operator
/// @param  precedence
/// @param  script
/// @param returntype
/// @param  lhstype
/// @param  rhstype
/// @param  assoc
/// @argType    s,r,r,s,s,s,r
/// @returnType r
/// @hidden     true
function _ML_NewAssignOper(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {

	var ind = _ML_LiAOp_Create(argument0, argument1, argument6);
	_ML_LiF_AddSig(ind, argument4 +"$" + argument5, _ML_AddAssignSig(argument2, argument3));
	return ind;



}
