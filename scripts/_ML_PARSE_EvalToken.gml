///_ML_PARSE_EvalToken(parser, argTypeStack, token)
/// @argType    r,r,r
/// @returnType real
/// @hidden     true
var parser = argument0;
var args = argument1;
var tok = argument2;


switch (_ML_LiTok_GetType(tok)) {
case ML_TT_UNARY:
    _ML_PARSE_Unary(parser, tok, args);
break;
case ML_TT_BINARY:
    _ML_PARSE_Binary(parser, tok, args);
break;
case ML_TT_ASSIGN:
    _ML_PARSE_Assign(parser, tok, args);
break;
case ML_TT_TERNARY:
    _ML_PARSE_Ternary(parser, tok, args);
break;
case ML_TT_FUNCTION:
    _ML_PARSE_Function(parser, tok, args);
break;
case ML_TT_VALUE:
case ML_TT_VARIABLE:
    _ML_PARSE_Value(tok, args);
break;
case ML_TT_EXPRTERMINATOR:
    return true;
break;
}
return false;
