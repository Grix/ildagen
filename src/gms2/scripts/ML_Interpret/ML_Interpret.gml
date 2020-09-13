/// @description  ML_Interpret(parser, string)
/// @function  ML_Interpret
/// @param parser
/// @param  string
/// @argType    r, s
/// @returnType real
/// @hidden     false
function ML_Interpret(argument0, argument1) {

	var parser = argument0;
	var funcstr = argument1;
	var resobj = _ML_LiRO_Create();
	_ML_Interpret_Detail(parser, funcstr, resobj);

	return resobj;



}
