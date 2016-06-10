with (controller)
{
    dac = dac_list[| argument0];
    if (!ds_exists(dac,ds_type_list))
    {
        dac = -1;
        return 0;
    }
    dac_string = dac[| 2];
    laseron = false;
}
