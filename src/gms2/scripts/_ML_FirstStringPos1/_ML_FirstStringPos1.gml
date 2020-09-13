/// @description  _ML_FirstStringPos1(str, token1)
/// @function  _ML_FirstStringPos1
/// @param str
/// @param  token1
/// @argType    s,s
/// @returnType r
/// @hidden     true
function _ML_FirstStringPos1(argument0, argument1) {

	var num, str, pos;
	num = 1;
	str = argument0;

	pos = string_pos(argument1, argument0);

	return pos;



}
