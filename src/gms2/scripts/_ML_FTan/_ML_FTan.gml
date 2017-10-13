if (argument0 mod pi == 0 ) {
    ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"complex answer to tangent( " + string(argument0) + " )");
    return argument0;
}


return tan(argument0);
