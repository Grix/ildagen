if (ds_map_exists(argument0.ActualFunctions, argument1) ) {
    return ds_map_find_value(argument0.ActualFunctions, argument1);
} else {
    return -1;
}
