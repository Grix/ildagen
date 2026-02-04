// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dd_select_dmx_interface(){
	num = dacwrapper_dmx_scan_interfaces();
	if (argument[0] >= num)
		return;
	var t_interface_ip = dacwrapper_get_interface_ip(argument[0]);
	obj_dmx_interface_selector.chosen_interface = t_interface_ip;
	dacwrapper_dmx_set_ip(t_interface_ip);
}