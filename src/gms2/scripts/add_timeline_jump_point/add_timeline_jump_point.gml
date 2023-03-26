// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_timeline_jump_point(){
	with (seqcontrol)
	{
		var t_found = false;
		for (i = 0; i < ds_list_size(jump_button_list); i += 2)
		{
			if (jump_button_list[| i+1] == tlpos*projectfps/1000)
			{
				ds_list_delete(jump_button_list, i);
				ds_list_delete(jump_button_list, i);
				t_found = true;
				break;
			}
		}
	
		if (!t_found)
		{
			ds_list_add(jump_button_list, -1);
			ds_list_add(jump_button_list, tlpos*projectfps/1000);
		}
	}
}