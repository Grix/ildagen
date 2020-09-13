/// @description ML_InitParserEmpty(VarMap)
/// @function ML_InitParserEmpty
/// @param VarMap
/// @argType    r
/// @returnType real
/// @hidden     false
function ML_InitParserEmpty(argument0) {
	/*
	**  Usage:
	**      ML_InitParserEmpty(VarMap)
	**
	**  Arguments:
	**      VarMap      Map that will contain all variables
	**
	**  Returns:
	**      Parser ID used for further functions
	**
	**  Notes:
	**      Creates completely empty parser
	*/


	var ind = _ML_LiP_Create("", argument0);
	global._ML_CURRENTPARSER_ = ind;

	return ind;



}
