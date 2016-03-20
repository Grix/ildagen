//scans for available dacs (and resets all)

//cleanup
for (i = ds_list_size(dac_list)-1; i >= 0; i--)
{
    var dac = dac_list[| i];
    if (dac[| 1] == 0)
    {
        //RIYA
        dac_riya_close(dac[| 0]);
        if (ds_exists(dac[| 3], ds_type_map))
            ds_map_destroy(dac[| 3]);
        if (ds_exists(dac, ds_type_list))
            ds_list_destroy(dac);
    }
}
ds_list_clear(dac_list);
dac = -1;
dac_string = "[None]";

//RIYA
for (i = 0; i < 4; i++)
{
    var result = dac_riya_newdevice(i);
    if (result > 0)
    {
        var dac = ds_list_create();
        ds_list_add(dac,result);
        ds_list_add(dac,0);
        ds_list_add(dac,"RIYA "+string(i)); //dac_riya_get_description(result));
        ds_list_add(dac,ds_map_create());
        ds_list_add(dac_list,dac);
    }
    else
    {   
        break;
    }
}
