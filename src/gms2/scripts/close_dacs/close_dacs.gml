//cleanup
for (i = 0; i < ds_list_size(dac_list); i++)
{
    var daclist = dac_list[| i];
    if (ds_exists(daclist, ds_type_list))
        dac_blank_and_center(daclist);
}
