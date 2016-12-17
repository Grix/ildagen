ddobj = instance_create(mouse_x,mouse_y,oDropDown);

//dactoselect is id in list of right clicked dac

with (ddobj)
{
    num = 2;
    ds_list_add(desc_list,"Select as default");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dac_select_dd);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Rename DAC");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dac_rename_dd);
    ds_list_add(hl_list,(ds_list_find_value(controller.dac_list[| settingscontrol.dactoselect], 3) != -1));
    
    for (i = 0; i < ds_list_size(seqcontrol.projector_list); i++)
    {
        ds_list_add(desc_list,"Add under ["+ds_list_find_value(seqcontrol.projector_list[| i], 1)+"]");
        ds_list_add(sep_list,(i == 0));
        ds_list_add(scr_list,dac_addtoprojector_dd);
        ds_list_add(hl_list,1);
        num++;
    }
    
    event_user(1);
}
