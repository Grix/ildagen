/// @description  _ML_PARSE_Binary(parser, tok, argstack)
/// @function  _ML_PARSE_Binary
/// @param parser
/// @param  tok
/// @param  argstack
/// @argType    r,r,r
/// @returnType void
/// @hidden     true
function _ML_PARSE_Binary(argument0, argument1, argument2) {
	var VARMAP = _ML_LiP_GetVarMap(argument0);
	var token = argument1;
	var argstack = argument2;
	var op, lhs, rhs, lhs_val, rhs_val, ret, rhs_type, lhs_type, v;

	op = _ML_LiTok_GetOperator(token);
	if (ds_stack_size(argstack) < 2) {
	    ML_RaiseException_CurParser(ML_EXCEPT_BINOPERATOR, _ML_LiTok_GetPos(token),
	            "missing value for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
	    return 0;   
	}
	rhs = ds_stack_pop(argstack);
	if (_ML_LiTok_GetType(rhs) == ML_TT_VALUE) {
	    rhs_val = _ML_LiTok_GetVal(rhs);
	    rhs_type = _ML_LiTok_GetOperator(rhs);
	} else {
	    v = _ML_LiTok_GetOperator(rhs);
	    rhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
	    rhs_type = _ML_LiVar_GetType(v);
	}
	lhs = ds_stack_top(argstack);
	if (_ML_LiTok_GetType(lhs) == ML_TT_VALUE) {
	    lhs_val = _ML_LiTok_GetVal(lhs);
	    lhs_type = _ML_LiTok_GetOperator(lhs);
	} else {
	    v = _ML_LiTok_GetOperator(lhs);
	    lhs_val = ds_map_find_value(VARMAP, _ML_Li_GetName(v));
	    lhs_type = _ML_LiVar_GetType(v);
	}
	var exact_operator, argstring;

	argstring = lhs_type + "$" + rhs_type;

	exact_operator = _ML_LiF_GetFunc(op, argstring)

	if (exact_operator < 0) {
	    ML_RaiseException_CurParser(ML_EXCEPT_ARGTYPE,_ML_LiTok_GetPos(token),
	        "Invalid argument type for '" + string(_ML_LiTok_GetVal(token)) +"' at " +string(_ML_LiTok_GetPos(token)));
	    return 0;
	} 
	ret = script_execute(_ML_LiS_GetScript(exact_operator),lhs_val,rhs_val);
	//create "temp" token with lhs_val:
	_ML_LiTok_SetString(lhs, ret);
	_ML_LiTok_SetType(lhs, ML_TT_VALUE);
	_ML_LiTok_SetOperator(lhs, _ML_LiS_GetRettype(exact_operator));



}
