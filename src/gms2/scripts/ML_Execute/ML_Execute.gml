/// @description ML_Execute(parser, compile)
/// @function ML_Execute
/// @param parser
/// @param  compile
/// @argType    r, r
/// @returnType real
/// @hidden     false
function ML_Execute(argument0, argument1) {


	/*
	**  Usage:
	**      ML_Execute(parser, compile)
	**
	**  Arguments:
	**      parser      parser index
	**      compile     compiled expression
	**
	**  Returns:
	**      Result object
	**
	**  Notes:
	*/

	var parser = argument0;
	var compile = argument1;
	var result = _ML_LiRO_Create();

	try
	{

		global._ML_CURRENTPARSER_ = parser;
		if (ML_NoException(parser)) {
		    var ans = _ML_ParseCompiled(parser, compile, result);
		    if (ML_NoException(parser)) {
		        _ML_LiRO_SetFinal(result, ans);
		        _ML_LiRO_SetCalculated(result, true);
		    }
		}
	}
	catch (exception)
	{
		ML_RaiseException(parser, ML_EXCEPT_FUNCTION, -1, "Error during execution of function");
	}


	return result;



}
