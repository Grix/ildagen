///_ML_LEX_IsValue(token, prevtok)
/// @argType    r,r
/// @returnType r
/// @hidden     true

var vstr, i, s, prevtok;
vstr = string(_ML_LiTok_GetVal(argument0));
prevtok = argument1;
if (vstr == ".") return false;
var start_c;
start_c = string_char_at(vstr,1);
if (start_c == "'" || start_c == '"') return true;


s = string_length(vstr);
i = 1;
//before dot:
var c;
do {
    c = string_char_at(vstr,i);
    ++i;
    if (c == ".") break;
    if !_ML_LEX_Digit(c) return false;
    
} until (i > s)
if (c = "." && i <= s) {
    do {
        c = string_char_at(vstr,i);
        if !_ML_LEX_Digit(c) return false;
        ++i;
    } until (i > s)
}

return true;
