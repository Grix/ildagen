///_ML_COMP_Function( token, argstack)
/// @argType    r,r
/// @returnType void
/// @hidden     true

var token = argument0;
var argstack = argument1;
var f = _ML_LiTok_GetOperator(token);
var argstring = "";
var lhs, lhs_type;
var argc = _ML_LiTok_GetArgcount(token);
var tokentype, lhs_type;
for (var i = argc -1; i >= 0; --i) {
    lhs = ds_stack_pop(argstack);
    lhs_type = lhs[0];
    argstring = lhs_type + "$" + argstring;
}
argstring = string_copy(argstring,1,string_length(argstring) - 1);

var exact_func = _ML_LiF_GetFunc(f, argstring);

if (exact_func < 0) {
    ML_RaiseException_CurParser(ML_EXCEPT_ARGTYPE,_ML_LiTok_GetPos(token),
        "Invalid argument type for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
    return 0;
} 
_ML_LiTok_SetType(token, ML_TT_FUNCFLAT);
_ML_LiTok_SetOperator(token, exact_func);
var ctt;
ctt[0] = _ML_LiS_GetRettype(exact_func);
ctt[1] = ML_CTT_VARIABLE;
ds_stack_push(argstack, ctt);
