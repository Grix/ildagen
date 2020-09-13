/// @description  _ML_NewFunction(function_string,script,returntype, arglist)
/// @function  _ML_NewFunction
/// @param function_string
/// @param script
/// @param returntype
/// @param  arglist
/// @argType    s,r,s,r
/// @returnType r
/// @hidden     true
function _ML_NewFunction(argument0, argument1, argument2, argument3) {

	var ind = _ML_LiF_Create(argument0);
	var argstr = "";
	var c = ds_list_size(argument3);
	if (c > 0) {
	    argstr = ds_list_find_value(argument3, 0);
	    for (var i = 1; i < c; ++i) {
	        argstr += "$" + ds_list_find_value(argument3, i);
	    }
	}

	_ML_LiF_AddSig(ind, argstr, _ML_AddFunctionSig(argument1, argument2));
	return ind;



}
