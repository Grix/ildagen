///_ML_LEX_Word(char)
/// @argType    s
/// @returnType r
/// @hidden     true
var v = ord(argument0);
return (v >= 48 && v <= 57) || (v >= 65 && v <= 90) || (v >= 97 && v <= 122) || v == 95;
