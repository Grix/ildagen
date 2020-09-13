/// @description _ML_LEX_Digit(char)
/// @function _ML_LEX_Digit
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
function _ML_LEX_Digit(argument0) {
	//echecks  if character is digit
	var v = ord(argument0);
	return (v >= 48 && v <= 57);



}
