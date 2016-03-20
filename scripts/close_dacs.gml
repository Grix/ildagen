//cleanup
for (i = ds_list_size(dac_list)-1; i >= 0; i--)
{
    var dac = dac_list[| i];
    if (dac[| 1] == 0)
    {
        //RIYA
        dac_riya_close(dac[| 0]);
    }
}
