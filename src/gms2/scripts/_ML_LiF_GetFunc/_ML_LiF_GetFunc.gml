/// @description _ML_LiF_GetFunc(baseopid, signature_string)
/// @function _ML_LiF_GetFunc
/// @param baseopid
/// @param  signature_string
/// @argType    r, s
/// @returnType real
/// @hidden     true
function _ML_LiF_GetFunc(argument0, argument1) {
	var ActualFunctions = _ML_LiF_GetFuncs(argument0);
	if (ds_map_exists(ActualFunctions, argument1) ) {
	    return ds_map_find_value(ActualFunctions, argument1);
	} else {
	    return -1;
	}



}
