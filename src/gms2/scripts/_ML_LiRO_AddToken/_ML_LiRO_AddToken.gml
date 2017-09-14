/// @description _ML_LiRO_AddToken(res_obj, token, )
/// @function _ML_LiRO_AddToken
/// @param res_obj
/// @param  token
/// @param  
/// @argType    r
/// @returnType real
/// @hidden     true
var lhs_val = 0;
var lhs_type;
var VARMAP = ML_VM_Get(argument0);
var res_obj = argument1;
var lhs = argument2;
if (_ML_LiTok_GetType(lhs) == ML_TT_VALUE) {
    lhs_val = _ML_LiTok_GetVal(lhs);
    lhs_type = _ML_LiTok_GetOperator(lhs);
    _ML_LiRO_Add(res_obj, lhs_val, lhs_type);
} else if (_ML_LiTok_GetType(lhs) == ML_TT_VARIABLE)  {
    var v = _ML_LiTok_GetOperator(lhs);
    lhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
    lhs_type = _ML_LiVar_GetType(v);
    _ML_LiRO_Add(res_obj, lhs_val, lhs_type);
}
return lhs_val;
