/// @description _ML_SY_TokenIsOperator(tok)
/// @function _ML_SY_TokenIsOperator
/// @param tok
/// @argType    r
/// @returnType r
/// @hidden     true
var t = _ML_LiTok_GetType(argument0);

return (t == ML_TT_TERNARY1 || t == ML_TT_TERNARY2 ||
        t == ML_TT_TERNARY || t == ML_TT_BINARY || 
        t == ML_TT_UNARY || t == ML_TT_ASSIGN );
