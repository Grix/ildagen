///_ML_COMP_EvalToken(parser, argTypeStack, token)
/// @argType    r,r
/// @returnType real
/// @hidden     true
var parser = argument0;
var argTypeStack = argument1;
var tok = argument2;


switch (_ML_LiTok_GetType(tok)) {
case ML_TT_UNARY:
    _ML_COMP_Unary(tok, argTypeStack);
break;
case ML_TT_BINARY:
    _ML_COMP_Binary(tok, argTypeStack);
break;
case ML_TT_ASSIGN:
    _ML_COMP_Assign(tok, argTypeStack);
break;
case ML_TT_TERNARY:
    _ML_COMP_Ternary(tok, argTypeStack);
break;
case ML_TT_FUNCTION:
    _ML_COMP_Function(tok, argTypeStack);
break;
case ML_TT_VARIABLE:
    _ML_COMP_Variable(tok, argTypeStack);
break;
case ML_TT_VALUE:
    _ML_COMP_Value(tok, argTypeStack);
break;
case ML_TT_EOL:
case ML_TT_EXPRTERMINATOR:
    return true;
break;
}
return false;
