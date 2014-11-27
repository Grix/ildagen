///_ML_LiRO_Create()
/// @argType    
/// @returnType real
/// @hidden     true

var ind = ds_list_create();
ds_list_add(ind, false) //set calculated 0
ds_list_add(ind, 0); //answer 1
ds_list_add(ind, ds_list_create()); //all answers 2
ds_list_add(ind, ds_list_create()); //all answers type 3

return ind;
