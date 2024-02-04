/// @description _ML_LiRO_Destroy(ind);
/// @function _ML_LiRO_Destroy
/// @param ind
/// @argType    r
/// @returnType void
/// @hidden     true
function _ML_LiRO_Destroy(argument0) {

	var ind = argument0;
	ds_list_free_pool(_ML_LiRO_GetAll(ind));
	ds_list_free_pool(_ML_LiRO_GetAllType(ind));


	ds_list_free_pool(ind);



}
