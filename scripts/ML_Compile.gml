///ML_Compile(parser, expression)
/// @argType    r, s
/// @returnType real
/// @hidden     false


/*
**  Usage:
**      ML_Compile(parser, expression)
**
**  Arguments:
**      parser      parser index
**      expression  expression string
**
**  Returns:
**      compile output to execute
**
**  Notes:
*/

var rpn, tokenlist, ans, newrpn;

var parser = argument0;
global._ML_CURRENTPARSER_ = parser;

var compile;

newrpn = ds_list_create();
if (!ML_NoException(parser)) return newrpn;

tokenlist = ds_list_create();
rpn = ds_list_create();
var important_tokens = ds_map_create();


do {
    _ML_LexicalAnalysis(parser, tokenlist, argument1);
    if (!ML_NoException(parser))  {break;}
    _ML_ShuntingYard(parser, tokenlist, rpn);  
    if (!ML_NoException(parser))  {break;}
    _ML_COMP_EvalAll(parser, rpn, newrpn, important_tokens);
} until (1 == 1);


if (!ML_NoException(parser))  {
    _ML_TokCleanUp(tokenlist);
} else {
    _ML_COMP_RemoveExtraTokens(tokenlist, important_tokens);
}
ds_list_destroy(rpn);
ds_list_destroy(tokenlist);
ds_map_destroy(important_tokens);
return newrpn;


