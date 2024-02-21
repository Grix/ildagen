/// @description _ML_PARSE_EvalLine(parser, rpn, resultObject)
/// @function _ML_PARSE_EvalLine
/// @param parser
/// @param  rpn
/// @param  resultObject
/// @argType    r,r,r
/// @returnType auto
/// @hidden     true
function _ML_PARSE_EvalLine(argument0, argument1, argument2) {
	var parser = argument0;
	var rpn = argument1;
	var res_obj = argument2;
	var args = ds_stack_create();
	var expression_terminator = false;
	var tok;
	while (!ds_list_empty(rpn) && expression_terminator == false && ML_NoException(parser)) {
	    tok = ds_list_find_value(rpn, 0);
	    ds_list_delete(rpn, 0);
	    _ML_PARSE_EvalToken(parser, args, tok);

	}
	if (ML_NoException(parser)) {
	    if (ds_stack_size(args) > 1) {
	        ML_RaiseException(parser, ML_EXCEPT_VALUE,-1,
	            "missing operator or function in expression");
	    }
	}

	var lhs, lhs_val;
	if (!ds_stack_empty(args)) {
	    lhs = ds_stack_pop(args);
	    lhs_val = _ML_LiRO_AddToken(parser, res_obj, lhs);
	}
	ds_stack_destroy(args);
	return lhs_val;



}
