/// @description dac_send_frame(dac_list, buffer, size, rate)
/// @function dac_send_frame
/// @param dac_list
/// @param  buffer
/// @param  size
/// @param  rate
function dac_send_frame() {

	var t_dac = argument[0];
	var pps = argument[3];
	//if (t_dac[| 9] == true) // done in dacwrapper
		//pps *= 0.7; 
	dacwrapper_outputframe(t_dac[| 0], pps, argument[2], buffer_get_address(argument[1]));
	t_dac[| 9] = false;


}
