/// @description _ML_LiTok_ToBuff(buffer, tok);
/// @function _ML_LiTok_ToBuff
/// @param buffer
/// @param  tok
/// @argType    r, r
/// @returnType void
/// @hidden     true
function _ML_LiTok_ToBuff(argument0, argument1) {

	//[type, val, pos, argcount]



	var tok = argument1;
	var s = ds_list_size(tok);
	var b = argument0;

	var type, val;
	val = _ML_LiTok_GetType(tok);
	type = buffer_u8;
	//_ML_C_DataInBuff(b, val, type);
	val = _ML_LiTok_GetVal(tok);
	if (is_string(val)) {
	    type = buffer_string;
	} else {
	    type = buffer_f64;
	}/*
	_ML_C_DataInBuff(b, val, type);
	val = _ML_LiTok_GetPos(tok);
	type = buffer_u32;
	_ML_C_DataInBuff(b, val, type);

	val = _ML_LiTok_GetArgcount(tok);
	type = buffer_u32;
	_ML_C_DataInBuff(b, val, type);//*/



}
