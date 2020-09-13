/// @description _ML_Parse(parser, ReversePolishQueue, ResultObject)
/// @function _ML_Parse
/// @param parser
/// @param  ReversePolishQueue
/// @param  ResultObject
/// @argType    r,r,r
/// @returnType auto
/// @hidden     true
function _ML_Parse(argument0, argument1, argument2) {

	//reverse polish notation of tokens;
	var parser = argument0;
	var rpn = argument1;
	var res_obj = argument2;
	var lhs_val = 0;

	var VARMAP = _ML_LiP_GetVarMap(parser);

	while (!ds_list_empty(rpn) && ML_NoException(parser)) {
	    lhs_val = _ML_PARSE_EvalLine(parser, rpn, res_obj);
	}
	return lhs_val;



}
