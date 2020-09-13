/// @description _ML_SY_HandleValue(token, exprqueue)
/// @function _ML_SY_HandleValue
/// @param token
/// @param  exprqueue
/// @argType    r,r
/// @returnType real
/// @hidden     true
function _ML_SY_HandleValue(argument0, argument1) {
	//ds_queue_enqueue(argument1, argument0);
	ds_list_add(argument1, argument0);
	return false;



}
