/// @description _ML_EC_DataInBuff(buff, data, type)
/// @function _ML_EC_DataInBuff
/// @param buff
/// @param  data
/// @param  type
/// @argType    r, a, r
/// @returnType void
/// @hidden     true

var buff = argument0;
var data = argument1;
var type = argument2;

buffer_write(buff, buffer_u8, type);
buffer_write(buff, type, data);
