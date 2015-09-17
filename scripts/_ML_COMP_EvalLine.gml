///_ML_COMP_EvalLine(parser, ReversePolishQueue,  newRPN, importantTokenList)
/// @argType    r,r,r,r
/// @returnType void
/// @hidden     true
var expression_terminator = false;
var args = ds_stack_create();
var newrpn = argument2;
var parser = argument0;
var rpn = argument1;
var important_tokens = argument3;
var tok;

var empty = ds_list_empty(rpn);
var firsttok = true;
while (!empty && expression_terminator == false && ML_NoException(parser)) {
    tok = ds_list_find_value(rpn, 0);
    ds_list_delete(rpn, 0);
    empty = ds_list_empty(rpn);
    
    expression_terminator= _ML_COMP_EvalToken(parser, args, tok);
    
    if !(expression_terminator && (empty || firsttok) ) {
        ds_map_add(important_tokens, tok, 0);
        ds_list_add(newrpn, tok);
        firsttok = false;
    }
    
}
if (ML_NoException(parser)) {
    if (ds_stack_size(args) > 1) {
        ML_RaiseException(ML_EXCEPT_VALUE,-1,
            "missing operator or function in expression");
    }
}
ds_stack_destroy(args);
