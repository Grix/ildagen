///_ML_LiF_AddSig(operator_id, argstring, actual_functor)
var ActualFunctions = ds_list_find_value(argument0, ML_LIFUNC_ACTUAL);
ds_map_add(ActualFunctions, argument1, argument2);

