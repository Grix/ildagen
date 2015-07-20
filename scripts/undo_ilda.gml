if (ds_list_empty(controller.undo_list))
    exit;

ilda_cancel();
    
undo = ds_list_find_value(controller.undo_list,ds_list_size(controller.undo_list)-1);
ds_list_delete(controller.undo_list,ds_list_size(controller.undo_list)-1);

if (is_real(undo))
    {
    for (j = 0;j < ds_list_size(controller.frame_list);j++)
        {
        el_list = ds_list_find_value(controller.frame_list,j);
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == undo)
                {
                list_id = ds_list_find_value(el_list,i);
                ds_list_destroy(list_id);
                ds_list_delete(el_list,i);
                }
            }
        }
    }
else if (string_char_at(undo,0) == 'a')
    {
    controller.maxframes = real(string_digits(undo));
    if (controller.frame > controller.maxframes) controller.frame = controller.maxframes-1;
    }
else if (string_char_at(undo,0) == 'r')
    {
    if (string_digits(undo) == "rauto")
        controller.resolution = clamp(real(string_digits(undo)),4,$ffff);
    else
        controller.resolution = "auto";
    }
else if (string_char_at(undo,0) == 'd')
    {
    controller.dotmultiply = real(string_digits(undo));
    }
else if (string_char_at(undo,0) == 'v')
    {
    if (!ds_exists(real(string_digits(undo)),ds_type_list))
        exit;
    tempundolist = real(string_digits(undo));
    controller.anicolor1 = ds_list_find_value(tempundolist,2);
    controller.anicolor2 = ds_list_find_value(tempundolist,1);
    controller.anienddotscolor = ds_list_find_value(tempundolist,0);
    ds_list_destroy(tempundolist);
    update_anicolors();
    }
else if (string_char_at(undo,0) == 'b')
    {
    if (!ds_exists(real(string_digits(undo)),ds_type_list))
        exit;
    tempundolist = real(string_digits(undo));
    controller.color1 = ds_list_find_value(tempundolist,2);
    controller.color2 = ds_list_find_value(tempundolist,1);
    controller.enddotscolor = ds_list_find_value(tempundolist,0);
    ds_list_destroy(tempundolist);
    update_colors();
    }
else if (string_char_at(undo,0) == 'k')
    {
    //undo reapply elements
    if (!ds_exists(real(string_digits(undo)),ds_type_list))
        exit;
    tempundolist = real(string_digits(undo));
    for (u = 0;u < ds_list_size(tempundolist);u++)
        {
        list = ds_list_find_value(tempundolist,u);
        tempid = ds_list_find_value(list,9);
        frame = ds_list_find_value(list,ds_list_size(list)-1);
        ds_list_delete(list,ds_list_size(list)-1);
        el_list = ds_list_find_value(controller.frame_list,frame);
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            if (ds_list_find_value(ds_list_find_value(el_list,i),9) == tempid)
                {
                oldlist = ds_list_find_value(el_list,i);
                ds_list_destroy(oldlist);
                ds_list_replace(el_list,i,list);
                }
            }
        }
    ds_list_destroy(tempundolist);
    }
else if (string_char_at(undo,0) == 'l')
    {
    if (!ds_exists(real(string_digits(undo)),ds_type_list))
        exit;
    //undo delete
    tempundolist = real(string_digits(undo));
    for (u = 0;u < ds_list_size(tempundolist);u++)
        {
        list = ds_list_find_value(tempundolist,u);
        tempid = ds_list_find_value(list,9);
        frame = ds_list_find_value(list,ds_list_size(list)-1);
        ds_list_delete(list,ds_list_size(list)-1);
        el_list = ds_list_find_value(controller.frame_list,frame);
        ds_list_add(el_list,list);
        }
    ds_list_destroy(tempundolist);
    }
    
    
with (controller)
    {
    frame_surf_refresh = 1;
    update_semasterlist_flag = 1;
    }