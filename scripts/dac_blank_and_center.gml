///dac_blank_and_center(dac list)
if (!ds_exists(argument0, ds_type_list))
    exit;
    
dacwrapper_stop(argument0[| 0]);
