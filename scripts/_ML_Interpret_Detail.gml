/// _ML_Interpret_Detail(parser, string, resobj)
/// @argType    r, s, r
/// @returnType void
/// @hidden     true
/*
**  Usage:
**      ML_Interpret(parser, string, resobj)
**
**  Arguments:
**      parser      parser index
**
**  Returns:
**      result of expression
**
**  Notes:
*/

var rpn, tokenlist, ans;

var parser = argument0;
var func_string = argument1;
var res_obj = argument2;
global._ML_CURRENTPARSER_ = parser;

_ML_LiRO_SetCalculated(res_obj, false);
_ML_LiRO_Clear(res_obj);
if (!ML_NoException(parser)) return 0;

tokenlist = ds_list_create();
rpn = ds_list_create();

do {
    _ML_LexicalAnalysis(parser, tokenlist, func_string);
    if (!ML_NoException(parser))  {break;}
    
    _ML_ShuntingYard(parser, tokenlist, rpn);    
    if (!ML_NoException(parser))  { break;}
    ans = _ML_Parse(parser, rpn, res_obj);    
    if (!ML_NoException(parser)) {break;}
    _ML_LiRO_SetFinal(res_obj, ans);
    _ML_LiRO_SetCalculated(res_obj, true);
} until 1 = 1


//cleanup
ds_list_destroy(rpn);
_ML_TokCleanUp(tokenlist);
ds_list_destroy(tokenlist);

