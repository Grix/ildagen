/// @description _ML_LEX_Alpha(char)
/// @function _ML_LEX_Alpha
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
function _ML_LEX_Alpha(argument0) {
	//echecks  if character is alpha
	var v = ord(argument0);
	return (v >= 65 && v <= 90) || (v >= 97 && v <= 122);



}
