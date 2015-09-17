///_ML_PARSE_FuncFlat(parser, token, args, temptokens)
/// @argType    r,r,r,r
/// @returnType void
/// @hidden     true
var a, lhs, lhs_val, ret;

var VARMAP = _ML_LiP_GetVarMap(argument0);
var token = argument1;
var argstack = argument2;
var temptokens = argument3;

var func = _ML_LiTok_GetOperator(token);
var func_script = _ML_LiS_GetScript(func);
var argc = _ML_LiTok_GetArgcount(token);
for (var i = argc -1; i >= 0; --i) {
    lhs = ds_stack_pop(argstack);
    if (_ML_LiTok_GetType(lhs) == ML_TT_VALUE) {
        lhs_val = _ML_LiTok_GetVal(lhs);
    } else {
        var v = _ML_LiTok_GetOperator(lhs);
        lhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
    }
    a[i] = lhs_val;
}


switch (argc) {
case 15:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14]);
break;
case 14:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13]);
break;
case 13:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12]);
break;
case 12:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11]);
break;
case 11:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10]);
break;
case 10:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9]);
break;
case 9:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8]);
break;
case 8:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
break;
case 7:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5], a[6]);
break;
case 6:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4], a[5]);
break;
case 5:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3], a[4]);
break;
case 4:
    ret = script_execute(func_script, a[0], a[1], a[2], a[3]);
break;
case 3:
    ret = script_execute(func_script, a[0], a[1], a[2]);
break;
case 2:
    ret = script_execute(func_script, a[0], a[1]);
break;
case 1:
    ret = script_execute(func_script, a[0]);
break
case 0:
    ret = script_execute(func_script);
break;
}
//change the "function" by the "value"

var temptok = _ML_LiTok_Create(ret, _ML_LiTok_GetPos(token));
_ML_LiTok_SetType(temptok, ML_TT_VALUE);
_ML_LiTok_SetOperator(temptok, _ML_LiS_GetRettype(func));

ds_stack_push(argstack, temptok);
ds_list_add(temptokens, temptok);
