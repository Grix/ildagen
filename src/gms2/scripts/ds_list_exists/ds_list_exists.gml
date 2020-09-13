// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ds_list_exists(t_list){
	return (is_real(t_list) && ds_exists(t_list, ds_type_list));
}