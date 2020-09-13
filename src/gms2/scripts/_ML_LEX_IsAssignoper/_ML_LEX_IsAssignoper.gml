/// @description _ML_LEX_IsAssignoper(parser, token, prevtok)
/// @function _ML_LEX_IsAssignoper
/// @param parser
/// @param  token
/// @param  prevtok
/// @argType    r,r,r
/// @returnType r
/// @hidden     true
function _ML_LEX_IsAssignoper(argument0, argument1, argument2) {

	var vstr, ret, prevtok, t;
	var P_ASSIGNOPER = _ML_LiP_GetAssignOpsTable(argument0);
	prevtok = argument2;
	vstr = string(_ML_LiTok_GetVal(argument1));
	if !ds_map_exists(P_ASSIGNOPER, vstr) return false;
	ret = false;
	if (prevtok >= 0) {
	    switch (_ML_LiTok_GetType(prevtok)) {
	    case ML_TT_VARIABLE:
	        ret = true;
	    break;
	    }
	}
	return ret;



}
