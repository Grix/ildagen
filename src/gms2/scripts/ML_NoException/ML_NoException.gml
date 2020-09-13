/// @description ML_NoException(parser)
/// @function ML_NoException
/// @param parser
/// @argType    r
/// @returnType real
/// @hidden     false
function ML_NoException(argument0) {

	return (_ML_LiP_GetErrorFlags(argument0) == 0);



}
