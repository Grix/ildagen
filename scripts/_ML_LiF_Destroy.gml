///_ML_LiF_Destroy(index)
/// @argType    r
/// @returnType void
/// @hidden     true

var ActualFunctions = _ML_LiF_GetFuncs(argument0);
var ind = ds_map_find_first(ActualFunctions);
repeat (ds_map_size(ActualFunctions)) {
    _ML_LiS_Destroy(ds_map_find_value(ActualFunctions,ind));
    ind = ds_map_find_next(ActualFunctions, ind);
}
ds_map_destroy(ActualFunctions);
ds_list_destroy(argument0);
