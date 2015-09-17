///ML_RaiseException(parser, Exception, position, [string])
/// @argType    r,r,r,s
/// @returnType v
/// @hidden     false

/*
**  Usage:
**      ML_RaiseException(parser, Exception,position,[string])
**
**  Arguments:
**      Parser      Parser id
**      Exception   exception id of the exception (Can be build in or a custom)
**      position    positino of the expression (use -1 if you don't know)
**      string      string containing a textual description of the exception
**
**  Returns:
**
**  Notes:
*/

var ind = argument[0];
_ML_LiP_SetErrorFlags(ind, argument[1]);
_ML_LiP_SetErrorPos(ind, argument[2]);
if (argument_count > 3) {
    _ML_LiP_SetErrorString(ind, argument[3]);
}
