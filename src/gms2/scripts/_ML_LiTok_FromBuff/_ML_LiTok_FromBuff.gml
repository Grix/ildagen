/// @description _ML_LiTok_FromBuff(tok, buffer);
/// @function _ML_LiTok_FromBuff
/// @param tok
/// @param  buffer
/// @argType    r, r
/// @returnType void
/// @hidden     true
function _ML_LiTok_FromBuff(argument0, argument1) {

	//[type, val, pos, argcount]


	var tok = argument0;
	var b = argument1;

	var v, val_type;
	val_type = buffer_read(b, buffer_u8);
	v = _ML_BD_GetData(b, val_type);
	if (v[1]) { return 0}
	_ML_LiTok_SetType(tok, v[0]);



}
