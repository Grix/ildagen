///_ML_LEX_IsTernOper(parser, token, previoustoken)
/// @argType    r,r,r
/// @returnType r
/// @hidden     true


var vstr, p, ret, prevtok, t;
var P_TERNOPER = _ML_LiP_GetTernOpsTable(argument0);
prevtok = argument2;
vstr = string(_ML_LiTok_GetVal(argument1));

if !ds_map_exists(P_TERNOPER, vstr) return false;
if (prevtok >= 0) {
    switch (_ML_LiTok_GetType(prevtok)) {
    case ML_TT_UNARY:
        if (_ML_LiUOp_GetAffix(_ML_LiTok_GetOperator(prevtok)) == ML_UO_POSTFIX) {
            ret = true;
        }
    break;
    case ML_TT_RIGHTP:
    case ML_TT_VARIABLE:
    case ML_TT_VALUE:
        ret = true;
    break;
    }
}
return ret;
