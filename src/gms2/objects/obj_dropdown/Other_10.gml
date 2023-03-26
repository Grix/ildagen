/// @description Override me for each option
if (room == rm_ilda)
{
    with (controller) 
	{
		clean_redo_list();
        script_execute(ds_list_find_value(obj_dropdown.scr_list,obj_dropdown.selected));
	}
}
else if (room == rm_seq)
{
    with (seqcontrol) 
	{
		clean_redo_list_seq();
        script_execute(ds_list_find_value(obj_dropdown.scr_list,obj_dropdown.selected));
	}
}
else
{
    with (controller) 
	{
        script_execute(ds_list_find_value(obj_dropdown.scr_list,obj_dropdown.selected),obj_dropdown.selected);
	}
}
    
instance_destroy();

