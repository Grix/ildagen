/// @description Override me for each option
if (room == rm_ilda)
{
    with (controller) 
        script_execute(ds_list_find_value(oDropDown.scr_list,oDropDown.selected));
}
else if (room == rm_seq)
{
    with (seqcontrol) 
        script_execute(ds_list_find_value(oDropDown.scr_list,oDropDown.selected));
}
else
{
    with (controller) 
        script_execute(ds_list_find_value(oDropDown.scr_list,oDropDown.selected),oDropDown.selected);
}
    
instance_destroy();

