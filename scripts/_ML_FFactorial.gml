if (argument0 < 0 || argument0 > 21) {
    ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"Bad argument for factorial " + string(argument1) );
    return -1;
}

var result = 1;
for(var i = 2; i<= argument0; ++i) {
    result *= i;
}
return result;
