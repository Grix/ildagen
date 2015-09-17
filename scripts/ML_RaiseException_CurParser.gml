///ML_RaiseException_CurParser(Exception, position, [string])
/// @argType    r, r, s
/// @returnType real
/// @hidden     false

/*
**  Usage:
**      ML_RaiseException_CurParser( Exception,position,[string])
**
**  Arguments:
**      Exception   exception id of the exception. (Can be build in or a custom)
**      position    positino of the expression (use -1 if you don't know)
**      string      string containing a textual description of the exception
**
**  Returns:
**
**  Notes:
*/
if (argument_count >= 3) {
    ML_RaiseException(global._ML_CURRENTPARSER_, argument[0], argument[1], argument[2]);
} else {
    ML_RaiseException(global._ML_CURRENTPARSER_, argument[0], argument[1]);
}
