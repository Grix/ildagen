///dac_select(id in list)
with (controller)
{
    if (laseron)
        dac_blank_and_center(dac);
    
    var t_newdac = argument[0];
    dac = dac_list[| t_newdac];
    
    if (!ds_exists(dac,ds_type_list))
    {
        dac = -1;
        return 0;
    }

    dac[| 6] = false;
    laseron = false;
}

if (room == rm_options)
    surface_free(obj_dacs.surf_daclist);

return 1;
