/// @description ML_CompileCleanup(Compile)
/// @function ML_CompileCleanup
/// @param Compile
/// @argType    r
/// @returnType void
/// @hidden     false
var compile = argument0;

_ML_TokCleanUp(compile);
ds_list_destroy(compile);
