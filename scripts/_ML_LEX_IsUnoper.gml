///_ML_LEX_IsUnoper(parser, token, prevtok)
/// @argType    r,r,r
/// @returnType r
/// @hidden     true

var P_UNOPER = _ML_LiP_GetUnOpsTable(argument0);
var vstr, ret, prevtok, t, op;
prevtok = argument2;
vstr = string(_ML_LiTok_GetVal(argument1));
var tkey = ds_map_find_first(P_UNOPER);


if !ds_map_exists(P_UNOPER, vstr) return false;
op = ds_map_find_value(P_UNOPER,vstr);
if (prevtok >= 0) {
    ret = false;
    if (_ML_LiUOp_GetAffix(op) == ML_UO_PREFIX) {
        switch (_ML_LiTok_GetType(prevtok)) {
        case ML_TT_BINARY:
            ret = true;
        break;
        case ML_TT_UNARY:
            if (_ML_LiUOp_GetAffix(_ML_LiTok_GetOperator(prevtok)) == ML_UO_PREFIX ) {
                ret = true;
            }
        break;
        case ML_TT_LEFTP:
            ret = true;
        break;
        case ML_TT_ASSIGN:
            ret = true;
        break;
        case ML_TT_COMMA:
            ret = true;
        break;
        case ML_TT_ARGSEP:
            ret = true;
        break;
        }
    } else {
        switch (_ML_LiTok_GetType(prevtok)) {
        case ML_TT_UNARY:
            if (_ML_LiUOp_GetAffix(_ML_LiTok_GetOperator(prevtok)) == ML_UO_POSTFIX) {
                ret = true;
            }
        break;
        
        case ML_TT_RIGHTP:
            ret = true;
        break;
        case ML_TT_FUNCTION:
            ret = true;
        break;
        case ML_TT_VARIABLE:
            ret = true;
        break;
        case ML_TT_VALUE:
            ret = true;
        break;
        }
    }
} else {
    ret = (_ML_LiUOp_GetAffix(op) == ML_UO_PREFIX);
}
return ret;
