/// @description _ML_COMP_Variable( token, argstack)
/// @function _ML_COMP_Variable
/// @param  token
/// @param  argstack
/// @argType    r,r
/// @returnType void
/// @hidden     true
function _ML_COMP_Variable(argument0, argument1) {

	var tok = argument0;
	var argTypeStack = argument1;
	var v = _ML_LiTok_GetOperator(tok);
	var ctt;
	ctt[0] = _ML_LiVar_GetType(v);
	if (_ML_LiVar_GetReadonly(v)) {
	    ctt[1] = ML_CTT_VARIABLE;
	} else {
	    ctt[1] = ML_CTT_ASSIGNABLE;
	}
	ds_stack_push(argTypeStack, ctt);



}
