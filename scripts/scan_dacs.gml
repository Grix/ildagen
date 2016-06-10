//scans for available dacs (and resets all)
log("---dac scan result");

//cleanup
for (i = ds_list_size(controller.dac_list)-1; i >= 0; i--)
{
    var newdac = controller.dac_list[| i];
    if (newdac[| 1] == 0)
    {
        //RIYA
        dac_riya_close(newdac[| 0]);
        if (ds_exists(newdac[| 3], ds_type_map))
            ds_map_destroy(newdac[| 3]);
        if (ds_exists(newdac, ds_type_list))
            ds_list_destroy(newdac);
    }
    else if (newdac[| 1] == 1)
    {
        //lasdac
        dac_lasdac_close(newdac[| 0]);
        if (ds_exists(newdac[| 3], ds_type_map))
            ds_map_destroy(newdac[| 3]);
        if (ds_exists(newdac, ds_type_list))
            ds_list_destroy(newdac);
    }
}
controller.laseron = false;
ds_list_clear(controller.dac_list);
controller.dac = -1;
controller.dac_string = "[None]";

//RIYA
for (i = 0; i < 4; i++)
{
    var result = dac_riya_newdevice(i);
    if (result > 0)
    {
        var newdac = ds_list_create();
        ds_list_add(newdac,result);
        ds_list_add(newdac,0);
        ds_list_add(newdac,"RIYA "+string(dac_riya_get_description(result)));
        ds_list_add(newdac,ds_map_create());
        ds_list_add(controller.dac_list,newdac);
        log("riya");
    }
    else
    {   
        break;
    }
}

//lasdac
var result = dac_lasdac_newdevice();
if (result > 0)
{
    var newdac = ds_list_create();
    ds_list_add(newdac,result);
    ds_list_add(newdac,1);
    ds_list_add(newdac,"LASDAC");
    ds_list_add(newdac,ds_map_create());
    ds_list_add(controller.dac_list,newdac);
    log("lasdac");
}


