/// @description  _ML_FirstStringPos(str, token1,token2,...,token16)
/// @function  _ML_FirstStringPos
/// @param str
/// @param  token1
/// @param token2
/// @param ...
/// @param token16
/// @argType    s,s ... s
/// @returnType r
/// @hidden     true
function _ML_FirstStringPos() {

	var num, str, pos;
	num = argument_count - 1;
	str = argument[0];

	pos = 0;

	var i;
	for (i = 1; i <= num; ++i) {
	    tp = string_pos(argument[i], str);
	    if (tp != 0 && (tp < pos || pos == 0)) {
	        pos = tp;
	    }
	}

	return pos;



}
