///ML_InitParserEmpty(VarMap)
/// @argType    r
/// @returnType real
/// @hidden     false
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

