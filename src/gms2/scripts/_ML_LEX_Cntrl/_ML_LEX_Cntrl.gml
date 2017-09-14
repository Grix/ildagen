/// @description _ML_LEX_Cntrl(char)
/// @function _ML_LEX_Cntrl
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
//checks  if character is controll 
var v = ord(argument0);
return (v <= 31);
