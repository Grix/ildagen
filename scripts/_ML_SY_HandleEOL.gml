///_ML_SY_HandleEOL(parser, token, output, stack);
/// @argType    r,r,r,r
/// @returnType real
/// @hidden     true

var token, output, stack, parser;
parser = argument0;
token = argument1;
output = argument2;
stack = argument3;
while (!ds_stack_empty(stack)) {
    var t = ds_stack_pop(stack);
    //untill stack is empty
    if (_ML_LiTok_GetType(t) == ML_TT_ARGSEP || _ML_LiTok_GetType(t) == ML_TT_LEFTP ) {
        ML_RaiseException(parser, ML_EXCEPT_PARENTHESIS,_ML_LiTok_GetPos(t),
            "Mismatched parenthesis for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(t)));
    } else {
        //ds_queue_enqueue(output, t);
        ds_list_add(output, t);
    }
    //add top operator to output
}
//ds_queue_enqueue(output,token);
ds_list_add(output, token);
return false;
