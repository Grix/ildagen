ddobj = instance_create(x+50,y+22,oDropDown);
with (ddobj)
    {
    num = 1;
    for (i = 0; i < ds_list_size(controller.dac_list); i++)
        {
        var dac = controller.dac_list[| i];
        ds_list_add(desc_list,string(dac[| 2]));
        ds_list_add(sep_list,0);
        ds_list_add(scr_list,dac_select);
        ds_list_add(hl_list,(controller.dac == dac));
        num++;
        }
    ds_list_add(desc_list,"[Rescan for DACs]");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,scan_dacs);
    ds_list_add(hl_list,1);
    
    event_user(1);
    }
