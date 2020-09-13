/// @description _ML_LEX_IsFunction(parser, token, prevtok)
/// @function _ML_LEX_IsFunction
/// @param parser
/// @param  token
/// @param  prevtok
/// @argType    r,r,r
/// @returnType r
/// @hidden     true
function _ML_LEX_IsFunction(argument0, argument1, argument2) {

	var P_FUNCTION = _ML_LiP_GetFunctionTable(argument0);
	var vstr, p, ret, prevtok, t;
	prevtok = argument2;
	vstr = string(_ML_LiTok_GetVal(argument1));
	return ds_map_exists(P_FUNCTION, vstr);



}
