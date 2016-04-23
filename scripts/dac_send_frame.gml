///dac_send_frame(dac_list, buffer, size, rate)

active_dac = argument0;

if (active_dac[| 1] == 0) //riya
{
    dac_riya_outputframe(active_dac[| 0], argument3, argument2, buffer_get_address(argument1));
}
