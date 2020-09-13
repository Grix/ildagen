/// @description _ML_COMP_Value( token, argstack)
/// @function _ML_COMP_Value
/// @param  token
/// @param  argstack
/// @argType    r,r
/// @returnType void
/// @hidden     true
function _ML_COMP_Value(argument0, argument1) {

	var tok = argument0;
	var argTypeStack = argument1;
	var ctt;
	ctt[0] = _ML_LiTok_GetOperator(tok);
	ctt[1] = ML_CTT_CONSTANT;
	ds_stack_push(argTypeStack, ctt);



}
