active_dac = argument0;

if (active_dac[| 1] == 0) //riya
{
    log(dac_riya_outputframe(active_dac[| 0], opt_scanspeed, buffer_tell(argument1), buffer_get_address(argument1)));
}
