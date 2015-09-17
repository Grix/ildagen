///_ML_SY_OperatorActBefore(o1, o2)
/// @argType    r,r
/// @returnType real
/// @hidden     true
var o1p, o2p, o1a;
o1p = _ML_LiOp_GetPrec(argument0);
o2p = _ML_LiOp_GetPrec(argument1);
o1a = _ML_LiOp_GetAssoc(argument0);
return !(o1p < o2p || (o1a == ML_O_LEFTASSOC && o1p == o2p));
