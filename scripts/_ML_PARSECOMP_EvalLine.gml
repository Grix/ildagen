///_ML_PARSECOMP_EvalLine(parser, rpn, resultObject)
/// @argType    r,r,r
/// @returnType real
/// @hidden     true
var parser = argument0;
var rpn = argument1;
var res_obj = argument2;
var args = ds_stack_create();
var expression_terminator = false;
var tok, lhs, lhs_val, lhs_type;
var rpn_size = ds_list_size(rpn);
var tok_index = 0;
var temptokens = ds_list_create();

while (tok_index < rpn_size && expression_terminator == false && ML_NoException(parser)) {
    //tok = ds_queue_dequeue(rpn);
    tok = ds_list_find_value(rpn, tok_index);
    ++tok_index;
    expression_terminator = _ML_PARSECOMP_EvalToken(parser, args, tok, temptokens);
}
if (ML_NoException(parser)) {
    if (ds_stack_size(args) > 1) {
        ML_RaiseException(ML_EXCEPT_VALUE,-1,
            "missing operator or function in expression");
    }
}
if (!ds_stack_empty(args)) {
    lhs = ds_stack_pop(args);
    _ML_LiRO_AddToken(parser, res_obj, lhs);
}
ds_stack_destroy(args);

_ML_TokCleanUp(temptokens);
ds_list_destroy(temptokens);
return tok_index;
