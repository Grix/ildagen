///dac_send_frame(dac_list, buffer, size, rate)

var t_dac = argument[0];
dacwrapper_outputframe(t_dac[| 0], argument[3], argument[2], buffer_get_address(argument[1]));
