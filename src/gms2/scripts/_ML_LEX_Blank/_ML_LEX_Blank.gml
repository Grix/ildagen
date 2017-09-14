/// @description _ML_LEX_Blank(char)
/// @function _ML_LEX_Blank
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
//echecks  if character is space
var v = ord(argument0);
return (v == 32 || v == 9);
