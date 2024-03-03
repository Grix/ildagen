// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_action_history_ilda(t_string)
{
	if (ds_list_size(controller.action_history_list) > 30)
		ds_list_delete(controller.action_history_list, 0);
		
	ds_list_add(controller.action_history_list, t_string);
}