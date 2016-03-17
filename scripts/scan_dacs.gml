//scans for available dacs (and resets all)

//cleanup
for (i = 0; i > ds_list_size(dac_list); i++)
{
    var dac = dac_list[| i];
    if (dac[| 1] == 0)
    {
        //RIYA
        dac_riya_close(dac[| 0]);
    }
}
ds_list_clear(dac_list);

//RIYA
for (i = 0; i < 63; i++)
{
    var result = dac_riya_newdevice(i);
    if (result > 0)
    {
        var dac = ds_list_create();
        ds_list_add(dac,result);
        ds_list_add(dac,0);
        ds_list_add(dac_list,dac);
    }
    else
    {   
        break;
    }
}
