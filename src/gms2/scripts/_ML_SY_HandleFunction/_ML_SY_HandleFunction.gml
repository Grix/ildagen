/// @description _ML_SY_HandleFunction(token, functionstack)
/// @function _ML_SY_HandleFunction
/// @param token
/// @param  functionstack
/// @argType    r,r
/// @returnType real
/// @hidden     true
function _ML_SY_HandleFunction(argument0, argument1) {
	ds_stack_push(argument1, argument0);
	return false;



}
