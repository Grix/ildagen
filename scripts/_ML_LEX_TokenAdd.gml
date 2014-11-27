///_ML_LEX_TokenAdd(list, string, position)
/// @argType    r,s,r
/// @returnType r
/// @hidden     true

var ind = _ML_LiTok_Create(argument1, argument2);
ds_list_add(argument0, ind);

return ind;

