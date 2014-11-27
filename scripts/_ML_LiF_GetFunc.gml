///_ML_LiF_GetFunc(baseopid, signature_string)
/// @argType    r, s
/// @returnType real
/// @hidden     true
var ActualFunctions = _ML_LiF_GetFuncs(argument0);
if (ds_map_exists(ActualFunctions, argument1) ) {
    return ds_map_find_value(ActualFunctions, argument1);
} else {
    return -1;
}

