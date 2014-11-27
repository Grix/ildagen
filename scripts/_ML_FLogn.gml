
if (argument1 <= 0) {
    ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"value argument out of range for logn( " + string(argument0) +", "+ string(argument1) + " )");
    return argument1;
}
if (argument0 <= 0 || argument0 == 1) {
    ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"base argument out of range for logn( " + string(argument0) +", "+ string(argument1) + " )");
    return argument1;
}

return logn(argument0,argument1);
