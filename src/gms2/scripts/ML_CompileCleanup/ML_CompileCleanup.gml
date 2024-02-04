/// @description ML_CompileCleanup(Compile)
/// @function ML_CompileCleanup
/// @param Compile
/// @argType    r
/// @returnType void
/// @hidden     false
function ML_CompileCleanup(argument0) {
	var compile = argument0;

	_ML_TokCleanUp(compile);
	ds_list_free_pool(compile);



}
