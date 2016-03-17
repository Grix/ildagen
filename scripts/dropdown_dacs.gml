ddobj = instance_create(x+50,y+22,oDropDown);
with (ddobj)
    {
    num = 0;
    for (i = 0; i < ds_list_size(controller.dac_list); i++)
        {
        var dac = controller.dac_list[| i];
        ds_list_add(desc_list,string(dac[| 1]));
        ds_list_add(sep_list,0);
        ds_list_add(scr_list,dac_select);
        ds_list_add(hl_list,(controller.dac == dac[| 0]));
        num++;
        }
    if (num == 0) instance_destroy();
    
    event_user(1);
    }
