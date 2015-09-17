///_ML_PARSECOMP_EvalToken(parser, argTypeStack, token, temptokens)
/// @argType    r,r,r,r
/// @returnType real
/// @hidden     true
var parser = argument0;
var args = argument1;
var tok = argument2;
var temptokens = argument3;

switch (_ML_LiTok_GetType(tok)) {
case ML_TT_FUNCFLAT:
    _ML_PARSE_FuncFlat(parser, tok, args, temptokens);
break;
case ML_TT_ASSIGNFLAT:
    _ML_PARSE_AssignFlat(parser, tok, args, temptokens);
break;
case ML_TT_VARIABLE:
case ML_TT_VALUE:
    _ML_PARSE_Value(tok, args);
break;
case ML_TT_EXPRTERMINATOR:
    return true;
break;
}
return false;
