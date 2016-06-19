//scans for available dacs (and resets all)

//cleanup
controller.laseron = false;
//todo clean sublistsmaps
ds_list_clear(controller.dac_list);
controller.dac = -1;
controller.dac_string = "[None]";
numofdacs = dacwrapper_scandevices();

for (i = 0; i < numofdacs; i++)
{
    var newdac = ds_list_create();
    ds_list_add(newdac,i);
    ds_list_add(newdac,"DAC");
    ds_list_add(newdac,ds_map_create());
    ds_list_add(controller.dac_list,newdac);
}
