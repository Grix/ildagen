/// @description _ML_LEX_Alnum(char)
/// @function _ML_LEX_Alnum
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
//echecks  if character is alpha
var v = ord(argument0);
return (v >= 48 && v <= 57) || (v >= 65 && v <= 90) || (v >= 97 && v <= 122);
