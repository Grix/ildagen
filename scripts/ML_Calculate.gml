///ML_Calculate(parser)
/// @argType    r
/// @returnType real
/// @hidden     false
var parser = argument0;
var resobj =_ML_LiP_GetResultObject(parser); 
_ML_Interpret_Detail(parser, _ML_LiP_GetFunctionString(parser), resobj);

return _ML_LiRO_GetCalculated(resobj);
