///dac_send_frame(dac_list, buffer, size, rate)

active_dac = argument0;

dacwrapper_outputframe(active_dac[| 0], argument3, argument2, buffer_get_address(argument1));

log(argument1)

