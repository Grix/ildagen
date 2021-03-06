/// @description _ML_PARSECOMP_EvalToken(parser, argTypeStack, token, temptokens)
/// @function _ML_PARSECOMP_EvalToken
/// @param parser
/// @param  argTypeStack
/// @param  token
/// @param  temptokens
/// @argType    r,r,r,r
/// @returnType real
/// @hidden     true
function _ML_PARSECOMP_EvalToken(argument0, argument1, argument2, argument3) {
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



}
