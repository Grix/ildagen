ddobj = instance_create(mouse_x,mouse_y,oDropDown);

//projectortoselect is id in list of right clicked proj
//dactoselect is id of dac in this proj ^

with (ddobj)
{
    num = 1;
    ds_list_add(desc_list,"Remove DAC");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projector_remove_dac);
    ds_list_add(hl_list,1);
    event_user(1);
}


