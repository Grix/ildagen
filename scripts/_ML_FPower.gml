if (argument0 == 0 && argument1 == 0 ) {
    ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"undefined value 0 ^ 0")
    return argument0;
}
if (argument0 < 0 && floor(argument1) != argument1) {
    ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"non real answer in eq: "+string(argument0) +" ^ "+string(argument1));
    return argument0;
}

return power(argument0, argument1);
