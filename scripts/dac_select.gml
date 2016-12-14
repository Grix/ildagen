///dac_select(id in list)
with (controller)
{
    dac = dac_list[| argument0];
    
    if (!ds_exists(dac,ds_type_list))
    {
        dac = -1;
        return 0;
    }

    dac_string = dac[| 1];
    laseron = false;
}

if (room == rm_options)
    surface_free(obj_dacs.surf_daclist);

return 1;
