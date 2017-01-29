///dac_blank_and_center(dac list)

var t_dac = argument[0];

if (!ds_exists(t_dac, ds_type_list))
    exit;
    
dacwrapper_stop(t_dac[| 0]);
t_dac[| 6] = false;
t_dac[| 7] = 0;
