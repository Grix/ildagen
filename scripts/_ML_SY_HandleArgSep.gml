///_ML_SY_HandleArgSep(parser, token, output, stack);
/// @argType    r,r,r,r
/// @returnType real
/// @hidden     true
var token, output, stack, parser;
parser = argument0;
token = argument1;
output = argument2;
stack = argument3;

while (!ds_stack_empty(stack)) {
    if (_ML_LiTok_GetType(ds_stack_top(stack)) == ML_TT_LEFTP ) break;
    //ds_queue_enqueue(output, ds_stack_pop(stack));
    ds_list_add(output, ds_stack_pop(stack));
}
if (ds_stack_empty(stack)) {
    ML_RaiseException(parser, ML_EXCEPT_PARENTHESIS,_ML_LiTok_GetPos(token),
        "Mismatched parenthesis for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)))
}
return true;
