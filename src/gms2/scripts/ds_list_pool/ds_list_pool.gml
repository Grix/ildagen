// stack and map is created in controller create event

function ds_list_create_pool()
{
	var t_list;
	if (ds_stack_empty(global.list_pool))
	{
		t_list = ds_list_create();
	}
	else
	{
		t_list = ds_stack_pop(global.list_pool);
	}
	
	global.list_pool_is_taken[? t_list] = true;
	return t_list;
}

function ds_list_exists_pool(_list)
{
	return ds_map_exists(global.list_pool_is_taken, _list);
}

function ds_list_free_pool(_list)
{
	ds_list_clear(_list);
	ds_stack_push(global.list_pool, _list);
	ds_map_delete(global.list_pool_is_taken, _list);
}