///ML_CompileCleanup(Compile)
/// @argType    r
/// @returnType void
/// @hidden     false
var compile = argument0;

_ML_TokCleanUp(compile);
ds_list_destroy(compile);

