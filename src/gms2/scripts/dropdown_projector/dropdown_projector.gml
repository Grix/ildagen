ddobj = instance_create_layer(mouse_x,mouse_y,"foreground",oDropDown);

//projectortoselect is id in list of right clicked proj

with (ddobj)
{
    num = 2;
    ds_list_add(desc_list,"Remove all DACs");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_clear_dacs);
    ds_list_add(hl_list,(ds_list_size(ds_list_find_value(seqcontrol.layer_list[| settingscontrol.projectortoselect], 5)) != 0));
    ds_list_add(desc_list,"Rename Layer");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_rename);
    ds_list_add(hl_list,1);
    
    for (i = 0; i < ds_list_size(controller.dac_list); i++)
    {
        ds_list_add(desc_list,"Add DAC: ["+ds_list_find_value(controller.dac_list[| i], 1)+"]");
        ds_list_add(sep_list,(i == 0));
        ds_list_add(scr_list,projector_add_dac_dd);
        ds_list_add(hl_list,1);
        num++;
    }
    
    event_user(1);
}


