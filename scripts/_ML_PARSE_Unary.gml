///_ML_PARSE_Unary(parser, token, argstack)
/// @argType    r,r,r
/// @returnType void
/// @hidden     true
var op, lhs, lhs_val, ret, lhs_type;

var VARMAP = _ML_LiP_GetVarMap(argument0);
var token = argument1;
var argstack = argument2;

op = _ML_LiTok_GetOperator(token);
if (ds_stack_size(argstack) < 1) {
    ML_RaiseException_CurParser(ML_EXCEPT_UNOPERATOR,_ML_LiTok_GetPos(token),
            "missing value for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
    return 0;   
}
lhs = ds_stack_top(argstack);
if (_ML_LiTok_GetType(lhs) == ML_TT_VALUE) {
    lhs_val = _ML_LiTok_GetVal(lhs);
    lhs_type = _ML_LiTok_GetOperator(lhs);
} else {
    var v = _ML_LiTok_GetOperator(lhs);
    lhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
    lhs_type = _ML_LiVar_GetType(v);
}

var exact_operator, argstring;

argstring = lhs_type;

exact_operator = _ML_LiF_GetFunc(op, argstring)

if (exact_operator < 0) {
    ML_RaiseException_CurParser(ML_EXCEPT_ARGTYPE,_ML_LiTok_GetPos(token),
        "Invalid argument type for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
    return 0;
} 

ret = script_execute(_ML_LiS_GetScript(exact_operator),lhs_val);

//create "temp" token with lhs_val:
_ML_LiTok_SetString(lhs, ret);
_ML_LiTok_SetType(lhs, ML_TT_VALUE);
_ML_LiTok_SetOperator(lhs, _ML_LiS_GetRettype(exact_operator));
