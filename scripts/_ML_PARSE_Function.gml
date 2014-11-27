///_ML_PARSE_Function(parser, token, args)
/// @argType    r,r,r
/// @returnType void
/// @hidden     true
var a, argc , f, i, lhs, lhs_val, ret, t;

var VARMAP = _ML_LiP_GetVarMap(argument0);
var token = argument1;
var argstack = argument2;

f = _ML_LiTok_GetOperator(token);
argc = _ML_LiTok_GetArgcount(token);
var argstring, exact_func;
argstring = "";
for (i = argc -1; i >= 0; --i) {
    lhs = ds_stack_pop(argstack);
    if (_ML_LiTok_GetType(lhs) == ML_TT_VALUE) {
        if (_ML_LiTok_GetOperator(lhs) == ML_VAL_REAL) {
            t = ML_VAL_REAL;
            lhs_val = _ML_LiTok_GetVal(lhs);
        } else {
            t = ML_VAL_STRING;
            lhs_val = _ML_LiTok_GetVal(lhs);
        }
    } else {
        var v;
        v = _ML_LiTok_GetOperator(lhs);
        lhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
        t = _ML_LiVar_GetType(v);
    }
    argstring = t + "$" + argstring;
    a[i] = lhs_val;
}
argstring = string_copy(argstring,1,string_length(argstring) - 1);
exact_func = _ML_LiF_GetFunc(f, argstring)
if (exact_func < 0) {
    ML_RaiseException_CurParser(ML_EXCEPT_ARGTYPE,_ML_LiTok_GetPos(token),
        "Invalid argument type for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
    _ML_LiTok_SetString(argument0, 0);
    _ML_LiTok_SetType(argument0, ML_TT_VALUE);
    _ML_LiTok_SetOperator(argument0, ML_VAL_REAL);
    ds_stack_push(argstack,argument0);
    return 0;
} 

switch (argc) {
case 15:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14]);
break;
case 14:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13]);
break;
case 13:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12]);
break;
case 12:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]);
break;
case 11:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10]);
break;
case 10:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]);
break;
case 9:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]);
break;
case 8:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
break;
case 7:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5], a[6]);
break;
case 6:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4], a[5]);
break;
case 5:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3], a[4]);
break;
case 4:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2], a[3]);
break;
case 3:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1], a[2]);
break;
case 2:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0], a[1]);
break;
case 1:
    ret = script_execute(_ML_LiS_GetScript(exact_func), a[0]);
break
case 0:
    ret = script_execute(_ML_LiS_GetScript(exact_func));
break;
}
//change the "function" by the "value"
_ML_LiTok_SetString(token, ret);
_ML_LiTok_SetType(token, ML_TT_VALUE);
_ML_LiTok_SetOperator(token, _ML_LiS_GetRettype(exact_func));
ds_stack_push(argstack,token);
