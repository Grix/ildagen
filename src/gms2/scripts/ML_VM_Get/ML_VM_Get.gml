/// @description ML_VM_Get(parser)
/// @function ML_VM_Get
/// @param parser
/// @argType    r
/// @returnType real
/// @hidden     false
function ML_VM_Get(argument0) {
	/*
	**  Usage:
	**      ML_VM_Get()
	**
	**  Arguments:
	**      parser      parser index
	**
	**  Returns:
	**      CurrentVarMap id
	**
	**  Notes:
	**      Can be manually changed. Though do NOT delete entries unless sure no pointer exists anymore
	**      Ownership stays with parser
	*/


	return _ML_LiP_GetVarMap(argument0);



}
