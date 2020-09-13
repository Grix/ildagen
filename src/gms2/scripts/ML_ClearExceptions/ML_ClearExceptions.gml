/// @description ML_ClearExceptions(parser)
/// @function ML_ClearExceptions
/// @param parser
/// @argType    r
/// @returnType v
/// @hidden     false
function ML_ClearExceptions(argument0) {

	_ML_LiP_SetErrorFlags(argument0, 0);
	_ML_LiP_SetErrorPos(argument0, -1);
	_ML_LiP_SetErrorString(argument0, "");



}
