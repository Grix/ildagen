///_ML_ParseCompiled(parser, ReversePolishQueue, ResultObject)
/// @argType    r,r,r
/// @returnType auto
/// @hidden     true

//reverse polish notation of tokens;
var parser = argument0;
var rpn = argument1;
var res_obj = argument2;
var VARMAP = _ML_LiP_GetVarMap(parser);

var rpn_size = ds_list_size(rpn);
var tok_index = 0;
//while (!ds_queue_empty(rpn) && ML_NoException(parser)) {
while (tok_index < rpn_size && ML_NoException(parser)) {
    tok_index = _ML_PARSECOMP_EvalLine(parser, rpn, res_obj);
}

return _ML_LiRO_Get(res_obj, _ML_LiRO_Size(res_obj) - 1);
