/// @description _ML_COMP_EvalAll(parser, ReversePolishQueue, OutFuncList, OutTokList)
/// @function _ML_COMP_EvalAll
/// @param parser
/// @param  ReversePolishQueue
/// @param  OutFuncList
/// @param  OutTokList
/// @argType    r,r,r,r
/// @returnType auto
/// @hidden     true
var parser = argument0;
var rpn = argument1;
var newrpn = argument2;
var important_tokens = argument3;

while (!ds_list_empty(rpn) && ML_NoException(parser)) {
    _ML_COMP_EvalLine(parser, rpn, newrpn, important_tokens);

}
