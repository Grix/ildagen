/// @description _ML_LEX_Xdigit(char)
/// @function _ML_LEX_Xdigit
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
function _ML_LEX_Xdigit(argument0) {
	var v = ord(argument0);
	return  (v >= 48 && v <= 57) || (v >= 65 && v <= 70) || (v >= 97 && v <= 102);



}
