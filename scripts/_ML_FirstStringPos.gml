/// _ML_FirstStringPos(str, token1,token2,...,token16)
/// @argType    s,s ... s
/// @returnType r
/// @hidden     true

var num, str, pos;
num = argument_count - 1;
str = argument[0];

pos = 0;

var i;
for (i = 1; i <= num; ++i) {
    tp = string_pos(argument[i], str);
    if (tp != 0 && (tp < pos || pos == 0)) {
        pos = tp;
    }
}

return pos;
