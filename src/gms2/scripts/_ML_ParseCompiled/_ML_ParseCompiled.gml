/// @description _ML_ParseCompiled(parser, ReversePolishQueue, ResultObject)
/// @function _ML_ParseCompiled
/// @param parser
/// @param  ReversePolishQueue
/// @param  ResultObject
/// @argType    r,r,r
/// @returnType auto
/// @hidden     true
function _ML_ParseCompiled(argument0, argument1, argument2) {

	//reverse polish notation of tokens;
	var parser = argument0;
	var rpn = argument1;
	var res_obj = argument2;

	var rpn_size = ds_list_size(rpn);
	var tok_index = 0;
	//while (!ds_queue_empty(rpn) && ML_NoException(parser)) {
	while (tok_index < rpn_size && ML_NoException(parser)) {
	    tok_index = _ML_PARSECOMP_EvalLine(parser, rpn, res_obj);
	}
	
	var t_res_obj_size = _ML_LiRO_Size(res_obj);
	if (t_res_obj_size == 0)
	{
		ML_RaiseException(parser, ML_EXCEPT_VALUE, -1, "Empty function result");
		return 0;
	}

	return _ML_LiRO_Get(res_obj, t_res_obj_size - 1);



}
