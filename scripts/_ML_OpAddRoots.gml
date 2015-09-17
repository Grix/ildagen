/// _ML_OpAddRoots(parser, string)
/// @argType    r,s
/// @returnType r
/// @hidden     true


var P_ROOTS = _ML_LiP_GetOperatorRoots(argument0);

var operatorstring = argument1;
var length = string_length(operatorstring);
var tstr = "";
var v = 0;
var fullsize = 0;
for (var i = 1; i <= length; ++i) {
    tstr += string_char_at(operatorstring, i);
    v = ds_map_find_value(P_ROOTS, tstr);  
    if (i == length) {
        fullsize = 1;
    }
    if (is_array(v)) {
        v[@ 0] += 1;
        v[@ 1] += fullsize;
    } else {
        v[0] = 1;
        v[1] = fullsize;
        ds_map_add(P_ROOTS, tstr, v);
    }

}
return 0;
