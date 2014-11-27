///_ML_SY_HandleTernary2(parser, token, output, stack);
/// @argType    r,r,r,r
/// @returnType real
/// @hidden     true
var token, output, stack, mylist, t, o1, o2, parser;
parser = argument0;
token = argument1;
output = argument2;
stack = argument3;
var P_TERNOPER2 = _ML_LiP_GetTernOps2Table(parser);
mylist = ds_map_find_value(P_TERNOPER2, string(_ML_LiTok_GetVal(token)));
while (!ds_stack_empty(stack)) {
    t = ds_stack_top(stack);
    if (_ML_SY_TernaryIsMatchingToken(t, mylist))  break;
    //ds_queue_enqueue(output, ds_stack_pop(stack));
    ds_list_add(output, ds_stack_pop(stack));
}
if (ds_stack_empty(stack)) {
    ML_RaiseException(parser, ML_EXCEPT_TERNARY,_ML_LiTok_GetPos(token),
        "Mismatched ternary operator, 2nd part before matching 1st, '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)))
} else {
    t = ds_stack_top(stack);
    _ML_LiTok_SetString(t, string(_ML_LiTok_GetVal(t)) + string(_ML_LiTok_GetVal(token)));
    _ML_LiTok_SetType(t, ML_TT_TERNARY);
}
return true;
