/// @description ML_SetExpression(parser, expression)
/// @function ML_SetExpression
/// @param parser
/// @param  expression
/// @argType    r,s
/// @returnType void
/// @hidden     false
function ML_SetExpression(argument0, argument1) {
	/*
	**  Usage:
	**      ML_SetExpression(parser, expression)
	**
	**  Arguments:
	**      expression      expression string
	**
	**  Returns:
	**
	**  Notes:
	*/


	_ML_LiP_SetFunctionString(argument0, argument1);
	var res_obj = _ML_LiP_GetResultObject(argument0);
	_ML_LiRO_SetCalculated(res_obj, false);



}
