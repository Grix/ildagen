///_ML_COMP_Value( token, argstack)
/// @argType    r,r
/// @returnType void
/// @hidden     true

var tok = argument0;
var argTypeStack = argument1;
var ctt;
ctt[0] = _ML_LiTok_GetOperator(tok);
ctt[1] = ML_CTT_CONSTANT;
ds_stack_push(argTypeStack, ctt);
