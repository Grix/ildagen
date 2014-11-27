/// _ML_SY_TernaryIsMatchingToken(token1, map)
/// @argType    r,r
/// @returnType real
/// @hidden     true
//tests if token is in map
var t1, o1, entry;
t1 = argument0;
entry = argument1;
if (_ML_LiTok_GetType(t1) != ML_TT_TERNARY1) return false;
o1 = _ML_LiTok_GetOperator(t1);
return (ds_list_find_index(entry, o1) >= 0);

