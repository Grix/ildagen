// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_action_history_string(){
	var t_string = "";
	for (var t_i = 0; t_i < ds_list_size(controller.action_history_list); t_i++)
	{
		t_string += string(controller.action_history_list);
		t_string += ",";
	}
	return t_string;
}