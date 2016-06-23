//scans for available dacs (and resets all)


controller.laseron = false;
controller.dac = -1;
controller.dac_string = "[None]";
numofdacs = dacwrapper_scandevices();

//cleanup
for (i = 0; i < ds_list_size(controller.dac_list); i++)
{
    var t_dac = controller.dac_list[| i];
    if (ds_exists(t_dac, ds_type_list))
    {
        if (ds_exists(t_dac[| 2], ds_type_map))
            ds_map_destroy(t_dac[| 2]);
        ds_list_destroy(t_dac);
    }
}
ds_list_clear(controller.dac_list);

for (i = 0; i < numofdacs; i++)
{
    var newdac = ds_list_create();
    ds_list_add(newdac,i);
    ds_list_add(newdac,dacwrapper_getname(i));
    ds_list_add(newdac,ds_map_create());
    ds_list_add(controller.dac_list,newdac);
}
