///ML_Execute(parser, compile)
/// @argType    r, r
/// @returnType real
/// @hidden     false


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


global._ML_CURRENTPARSER_ = parser;
if (ML_NoException(parser)) {
    var ans = _ML_ParseCompiled(parser, compile, result);
    if (ML_NoException(parser)) {
        _ML_LiRO_SetFinal(result, ans);
        _ML_LiRO_SetCalculated(result, true);
    }
}


return result;
