/// _ML_COMP_Ternary(tok, argstack)
/// @argType    r,r
/// @returnType void
/// @hidden     true
var token = argument0;
var argstack = argument1;

var op = _ML_LiTok_GetOperator(token);
if (ds_stack_size(argstack) < 3) {
    ML_RaiseException_CurParser(ML_EXCEPT_TERNARY,_ML_LiTok_GetPos(argument0),
            "missing value for '" + string(_ML_LiTok_GetVal(argument0)) +"' at " +string(_ML_LiTok_GetPos(argument0)));
    return 0;   
}
var rhs = ds_stack_pop(argstack);
var rhs_type = rhs[0];

var mhs = ds_stack_pop(argstack);
var mhs_type = mhs[0];

var lhs = ds_stack_pop(argstack);
var lhs_type = lhs[0];

var argstring = lhs_type + "$" + mhs_type + "$" + rhs_type;
var exact_operator = _ML_LiF_GetFunc(op, argstring)

if (exact_operator < 0) {
    ML_RaiseException_CurParser(ML_EXCEPT_ARGTYPE,_ML_LiTok_GetPos(argument0),
        "Invalid argument type for '" + string(_ML_LiTok_GetVal(argument0)) +"' at " +string(_ML_LiTok_GetPos(argument0)));
    return 0;
} 
_ML_LiTok_SetType(token, ML_TT_FUNCFLAT);
_ML_LiTok_SetOperator(token, exact_operator);
_ML_LiTok_SetArgcount(token, 3);
var ctt;
ctt[0] = _ML_LiS_GetRettype(exact_operator);
ctt[1] = ML_CTT_VARIABLE;
ds_stack_push(argstack, ctt);
