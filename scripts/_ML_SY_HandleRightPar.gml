///_ML_SY_HandleRightPar(parser, token, output, stack, argcount, stackofoutputs, stackofstacks,  level);
/// @argType    r,r,r,r,r,r,r,r
/// @returnType real
/// @hidden     true
var token, output, stack, level, alloutput, allstack, newstack, newoutput, argc, parser;
parser = argument0;
token = argument1;
output = argument2;
stack = argument3;
argc = argument4;
level = argument7;
alloutput = argument5;
allstack = argument6;

while (!ds_stack_empty(stack)) {
    if (_ML_LiTok_GetType(ds_stack_top(stack)) == ML_TT_LEFTP)  break;
    //ds_queue_enqueue(output, ds_stack_pop(stack));
    ds_list_add(output, ds_stack_pop(stack));
}
if (ds_stack_empty(stack)) {
    ML_RaiseException(parser, ML_EXCEPT_PARENTHESIS,_ML_LiTok_GetPos(token),
        "Mismatched parenthesis for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)))
} else {
    var t = ds_stack_pop(stack); //remove left parenthesis
    
    if (level > 0 && ds_stack_empty(stack)) {
        //flatten the outputs
        newoutput = ds_stack_top(alloutput);
        newstack = ds_stack_top(allstack);
        //_ML_SY_QueueAppendQueue(newoutput, output); //append output queues
        _ML_SY_ListAppendList(newoutput, output);
        var f = ds_stack_pop(newstack);
        _ML_LiTok_SetArgcount(f, argc);
        //ds_queue_enqueue(newoutput, f);
        ds_list_add(newoutput, f);
        return true;
    }
}
return false;
