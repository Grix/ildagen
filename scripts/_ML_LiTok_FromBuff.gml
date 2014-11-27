///_ML_LiTok_FromBuff(tok, buffer);
/// @argType    r, r
/// @returnType void
/// @hidden     true

//[type, val, pos, argcount]


var tok = argument0;
var b = argument1;

var v, val_type;
val_type = buffer_read(b, buffer_u8);
v = _ML_BD_GetData(b, val_type);
if (v[1]) { return 0}
_ML_LiTok_SetType(tok, v[0]);

