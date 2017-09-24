/// @description Override me for each option
if (room == rm_ilda)
{
    with (controller) 
        script_execute(ds_list_find_value(obj_dropdown.scr_list,obj_dropdown.selected));
}
else if (room == rm_seq)
{
    with (seqcontrol) 
        script_execute(ds_list_find_value(obj_dropdown.scr_list,obj_dropdown.selected));
}
else
{
    with (controller) 
        script_execute(ds_list_find_value(obj_dropdown.scr_list,obj_dropdown.selected),obj_dropdown.selected);
}
    
instance_destroy();

