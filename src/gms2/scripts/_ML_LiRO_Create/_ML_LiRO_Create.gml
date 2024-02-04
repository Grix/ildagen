/// @description _ML_LiRO_Create()
/// @function _ML_LiRO_Create
/// @argType    
/// @returnType real
/// @hidden     true
function _ML_LiRO_Create() {

	var ind = ds_list_create_pool();
	ds_list_add(ind, false) //set calculated 0
	ds_list_add(ind, 0); //answer 1
	ds_list_add(ind, ds_list_create_pool()); //all answers 2
	ds_list_add(ind, ds_list_create_pool()); //all answers type 3

	return ind;



}
