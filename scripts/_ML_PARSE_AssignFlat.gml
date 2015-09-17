///_ML_PARSE_AssignFlat(parser, token, args, temptokens)
/// @argType    r,r,r
/// @returnType void
/// @hidden     true
var op, lhs, rhs, lhs_val, rhs_val, ret;

var VARMAP = _ML_LiP_GetVarMap(argument0);
var token = argument1;
var argstack = argument2;
var temptokens = argument3;
var func = _ML_LiTok_GetOperator(token);
var func_script = _ML_LiS_GetScript(func);
if (ds_stack_size(argstack) < 2) {
    ML_RaiseException_CurParser(ML_EXCEPT_BINOPERATOR,_ML_LiTok_GetPos(token),
            "missing value for'" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
    return 0;   
}
rhs = ds_stack_pop(argstack);
if (_ML_LiTok_GetType(rhs) == ML_TT_VALUE) {
    rhs_val = _ML_LiTok_GetVal(rhs);
} else {
    var v = _ML_LiTok_GetOperator(rhs);
    rhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
}
lhs = ds_stack_pop(argstack);
var v = _ML_LiTok_GetOperator(lhs);

if (_ML_LiTok_GetType(lhs) != ML_TT_VARIABLE || _ML_LiVar_GetReadonly(v)) {
    ML_RaiseException_CurParser(ML_EXCEPT_ASSIGN,_ML_LiTok_GetPos(token),
            "Left hand side is not assignable '" + string(_ML_LiTok_GetVal(lhs)) +"' at " +string(_ML_LiTok_GetPos(lhs)));
    return 0;
}

ret = script_execute(func_script, VARMAP, _ML_Li_GetName(v),rhs_val);
//create "temp" token with lhs_val:
var temptok = _ML_LiTok_Create(ret, _ML_LiTok_GetPos(token));
_ML_LiTok_SetType(temptok, ML_TT_VALUE);
_ML_LiTok_SetOperator(temptok, _ML_LiS_GetRettype(func));

ds_stack_push(argstack, temptok);
ds_list_add(temptokens, temptok);
