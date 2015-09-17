///ML_InitParserMath(VarMap)
/// @argType    r
/// @returnType real
/// @hidden     false
/*
**  Usage:
**      ML_InitParserMath(VarMap)
**
**  Arguments:
**      VarMap      Map that will contain all variables
**
**  Returns:
**      Parser ID used for further functions
**
**  Notes:
**      Creates Parser with functions adapted for simple mathematics
*/

var ind = ML_InitParserEmpty(argument0);

    ML_AddUnaryOper(ind, "!",17,_ML_FFactorial, ML_VAL_REAL, ML_VAL_REAL, ML_UO_POSTFIX);
    ML_AddUnaryOper(ind, "%",17,_ML_FProcent, ML_VAL_REAL, ML_VAL_REAL, ML_UO_POSTFIX);
    
    ML_AddUnaryOper(ind, "-",16,_ML_FNegate, ML_VAL_REAL, ML_VAL_REAL, ML_UO_PREFIX);
    ML_AddUnaryOper(ind, "+",16,_ML_FPositive, ML_VAL_REAL, ML_VAL_REAL, ML_UO_PREFIX);
    ML_AddUnaryOper(ind, "~",16,_ML_FBitnegate, ML_VAL_REAL, ML_VAL_REAL, ML_UO_PREFIX);
    
    ML_AddBinaryOper(ind, "^",15,_ML_FPower, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    
    ML_AddBinaryOper(ind, "*",14,_ML_FMultiply, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, "/",14,_ML_FDivide, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, "mod",14,_ML_FModulo, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, "div",14,_ML_FDivision, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
        //add basic operators
    ML_AddBinaryOper(ind, "+",13,_ML_FAdd, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, "-",13,_ML_FSubstract, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "<<",12,_ML_FBSL, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, ">>",12,_ML_FBSR, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "<",11,_ML_FLess, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, "<=",11,_ML_FLessequal, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, ">",11,_ML_FGreater, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, ">=",11,_ML_FGreaterequal, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "==",10,_ML_FIs, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    ML_AddBinaryOper(ind, "<>",10,_ML_FIsnot, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "&",9,_ML_FBitand, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "xor",8,_ML_FBitxor, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "|",7,_ML_FBitor, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "&&",6,_ML_FAnd, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "^^",5,_ML_FXor, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
    ML_AddBinaryOper(ind, "||",4,_ML_FOr, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);

    ML_AddAssignOper(ind, "=",2,_ML_FAssign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "=",2,_ML_FAssign, ML_VAL_STRING, ML_VAL_STRING, ML_VAL_STRING, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "+=",2,_ML_FSumassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "+=",2,_ML_FSumassign, ML_VAL_STRING, ML_VAL_STRING, ML_VAL_STRING, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "-=",2,_ML_FSubassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "/=",2,_ML_FDivassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "*=",2,_ML_FMulassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "%=",2,_ML_FModassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "<<=",2,_ML_FBSLassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, ">>=",2,_ML_FBSRassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "&=",2,_ML_FAndassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "|=",2,_ML_FOrassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
    ML_AddAssignOper(ind, "^=",2,_ML_FXorassign, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_RIGHTASSOC);
       
    ML_AddBinaryOper(ind, ",",1,_ML_FComma, ML_VAL_REAL, ML_VAL_REAL, ML_VAL_REAL, ML_O_LEFTASSOC);
    
return ind;
