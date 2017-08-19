if (debug_mode)
    log("prepare_output_points_unopt");

listsize = ((ds_list_size(list_id)-20)/4);
var t_blindzonelistsize = ds_list_size(controller.blindzone_list);

currentpos = 20;
currentposadjust = 4;

//walk through list to get lit length and static point count
var t_i;
for (t_i = 1; t_i < listsize; t_i++)
{
    currentpos += currentposadjust;
    //getting values from element list
    
    bl = ds_list_find_value(list_id,currentpos+2);
    if (!bl) 
        return true;
}

return false;
