/// @description _ML_LEX_Graph(char)
/// @function _ML_LEX_Graph
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true

var v = ord(argument0);
return (v >= 65 && v <= 90) || (v >= 97 && v <= 122);
