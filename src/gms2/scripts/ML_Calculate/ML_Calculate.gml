/// @description ML_Calculate(parser)
/// @function ML_Calculate
/// @param parser
/// @argType    r
/// @returnType real
/// @hidden     false
function ML_Calculate(argument0) {
	var parser = argument0;
	var resobj =_ML_LiP_GetResultObject(parser); 
	_ML_Interpret_Detail(parser, _ML_LiP_GetFunctionString(parser), resobj);

	return _ML_LiRO_GetCalculated(resobj);



}
