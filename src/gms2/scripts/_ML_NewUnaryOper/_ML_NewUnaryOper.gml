/// @description  _ML_NewUnaryOper(operator, precedence,script,returntype, lhstype, affix)
/// @function  _ML_NewUnaryOper
/// @param operator
/// @param  precedence
/// @param script
/// @param returntype
/// @param  lhstype
/// @param  affix
/// @argType    s,r,r,s,s,r
/// @returnType r
/// @hidden     true
function _ML_NewUnaryOper(argument0, argument1, argument2, argument3, argument4, argument5) {

	var assoc;
	if (argument5 == ML_UO_PREFIX) {
	    assoc = ML_O_RIGHTASSOC;
	} else {
	    assoc = ML_O_LEFTASSOC;
	}

	var ind = _ML_LiUOp_Create(argument0, argument1, assoc, argument5);
	_ML_LiF_AddSig(ind, argument4, _ML_AddUnarySig(argument2, argument3));
	return ind;



}
