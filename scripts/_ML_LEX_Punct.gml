///_ML_LEX_Punct(char)
/// @argType    s
/// @returnType r
/// @hidden     true

var v = ord(argument0);
return (v >= 33 && v <= 47) || (v >= 58 && v <= 64) || (v >= 91  && v <= 96) || (v >= 123);
