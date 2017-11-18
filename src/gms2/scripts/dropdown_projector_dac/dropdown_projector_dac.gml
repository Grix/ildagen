ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);

//projectortoselect is id in list of right clicked proj
//dactoselect is id of dac in this proj ^

with (ddobj)
{
    num = 1;
    
    ds_list_add(desc_list,"Remove DAC");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_remove_dac);
    ds_list_add(hl_list,1);
    
    for (i = 0; i < ds_list_size(controller.profile_list); i++)
    {
        ds_list_add(desc_list,"Set profile: ["+ds_map_find_value(controller.profile_list[| i], "name")+"]");
        ds_list_add(sep_list,(i == 0));
        ds_list_add(scr_list,projector_dac_setprofile_dd);
        ds_list_add(hl_list,1);
        num++;
    }
    event_user(1);
}


