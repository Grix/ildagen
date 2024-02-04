global.list_pool = ds_stack_create();
global.list_pool_is_freed = ds_map_create();

function ds_list_create_pool()
{
	if (ds_stack_empty(global.list_pool))
		return ds_list_create();
	
	var t_list = ds_stack_pop(global.list_pool);
	ds_map_delete(global.list_pool_is_freed, t_list);
	return t_list;
}

function ds_list_exists_pool(_list)
{
	return !ds_map_exists(global.list_pool_is_freed, _list);
}

function ds_list_free_pool(_list)
{
	ds_list_clear(_list);
	ds_stack_push(global.list_pool);
	global.list_pool_is_freed[? _list] = true;
}