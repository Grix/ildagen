// stack and map is created in controller create event

function ds_list_create_pool()
{
	gml_pragma("forceinline");
	return ds_list_create();
	
	/*var t_newlist = ds_list_create();
	ds_list_add(global.list_pool_id, t_newlist);
	ds_list_add(global.list_pool_is_alive, true);
	return ds_list_size(global.list_pool_id) - 1;*/
	
}

function ds_list_exists_pool(_list)
{
	gml_pragma("forceinline");
	return ds_list_exists(_list);
	
	/*if (_list < 0 || _list > (ds_list_size(global.list_pool_id) - 1))
		return false;
	else
		return global.list_pool_is_alive[| _list];*/
}

function ds_list_free_pool(_list)
{
	gml_pragma("forceinline");
	ds_list_destroy(_list);
	
	/*if (_list < 0 || _list > (ds_list_size(global.list_pool_id) - 1))
		return;
	else if (global.list_pool_is_alive[| _list])
	{
		ds_list_destroy(global.list_pool_id[| _list]);
		global.list_pool_is_alive[| _list] = false;
	}*/
}