///_ML_SY_HandleOperator(parser, token, output, stack)
/// @argType    r,r,r,r
/// @returnType real
/// @hidden     true
var token, output, stack, o1, o2, t, parser;
parser = argument0;
token = argument1;
output = argument2;
stack = argument3;
o1 = _ML_LiTok_GetOperator(token);
while (!ds_stack_empty(stack)) {
    t = ds_stack_top(stack);
    if !(_ML_SY_TokenIsOperator(t)) break;
    o2 = _ML_LiTok_GetOperator(t);
    if (_ML_SY_OperatorActBefore(o1, o2)) break;
    if (_ML_LiTok_GetType(t) == ML_TT_TERNARY1) {
        ML_RaiseException(parser, ML_EXCEPT_TERNARY,_ML_LiTok_GetPos(token),
            "syntax error. Token '"+ string(_ML_LiTok_GetVal(token)) +"' at "+ _ML_LiTok_GetPos(token) + " can't exist inside ternary operator");
        break;
    }
    //ds_queue_enqueue(output, ds_stack_pop(stack));
    ds_list_add(output, ds_stack_pop(stack));
}
ds_stack_push(stack, token);
return false;
