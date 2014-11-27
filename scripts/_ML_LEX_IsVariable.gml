///_ML_LEX_IsVariable(parser, token, prevtok)
/// @argType    r,r,r
/// @returnType r
/// @hidden     true

var P_VARIABLE = _ML_LiP_GetVariableTable(argument0);
var vstr, p, ret, prevtok, t;
prevtok = argument2;
vstr = string(_ML_LiTok_GetVal(argument1));
return ds_map_exists(P_VARIABLE, vstr);

