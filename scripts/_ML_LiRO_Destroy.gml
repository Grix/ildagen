///_ML_LiRO_Destroy(ind);
/// @argType    r
/// @returnType void
/// @hidden     true

var ind = argument0;
ds_list_destroy(_ML_LiRO_GetAll(ind));
ds_list_destroy(_ML_LiRO_GetAllType(ind));


ds_list_destroy(ind);
