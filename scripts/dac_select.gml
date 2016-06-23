with (controller)
{
    dac = dac_list[| argument0];
    
    if (!ds_exists(dac,ds_type_list))
    {
        dac = -1;
        return 0;
    }
    
    var t_result = dacwrapper_opendevice(dac[| 0]);
    if (!t_result)
    {
        dac = -1;
        return 0;
    }
    dac_string = dac[| 1];
    laseron = false;
}

return 1;
