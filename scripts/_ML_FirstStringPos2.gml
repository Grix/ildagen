/// _ML_FirstStringPos2(str, token1, token2)
/// @argType    s,s,s
/// @returnType r
/// @hidden     true

var num, str, pos, p1, p2;
num = 2;
str = argument[0];
pos = 0;

var i;
for (i = 0; i < num; ++i) {
    tp = string_pos(argument[i+1], str);
    if (tp != 0 && (tp < pos || pos == 0)) {
        pos = tp;
    }
}

return pos;
