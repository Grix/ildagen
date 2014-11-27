///_ML_LiP_Create(expression, variable_map)
/// @argType    r,r
/// @returnType real
/// @hidden     true

var ind = ds_list_create();
ds_list_add(ind, ds_map_create()); //binops 0
ds_list_add(ind, ds_map_create()); //unop 1
ds_list_add(ind, ds_map_create()); //assign 2
ds_list_add(ind, ds_map_create()); //ternop 3
ds_list_add(ind, ds_map_create()); //ternop2 4
ds_list_add(ind, ds_map_create()); //function 5
ds_list_add(ind, ds_map_create()); //variable 6

ds_list_add(ind, argument0); //executablestring 7
ds_list_add(ind, argument1); //variable-map 8
ds_list_add(ind, 0); //Error flags 9
ds_list_add(ind, -1); //error pos 10
ds_list_add(ind, ""); //error string 11
ds_list_add(ind, _ML_LiRO_Create()); //resobject 12

ds_list_add(ind, ds_map_create()); //all signature roots 16

return ind;
