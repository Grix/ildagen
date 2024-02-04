/// @description  _ML_TernaryAddSecond(parser, oper_2_string, ternary_id)
/// @function  _ML_TernaryAddSecond
/// @param parser
/// @param  oper_2_string
/// @param  ternary_id
/// @argType    r,s,r
/// @returnType r
/// @hidden     true
function _ML_TernaryAddSecond(argument0, argument1, argument2) {
	var P_TERNOPER2 = _ML_LiP_GetTernOps2Table(argument0);
	var entry;
	if (ds_map_exists(P_TERNOPER2,argument1)) {
	    entry = ds_map_find_value(P_TERNOPER2, argument1);
	} else {
	    entry = ds_list_create_pool();
	    ds_map_add(P_TERNOPER2, argument1, entry);
	}
	ds_list_add(entry, argument2);



}
