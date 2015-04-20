if (ds_list_size(controller.undo_list) == 0)
    exit;

with (controller)
    {
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    ds_list_clear(semaster_list);
    }
    
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
else if (string_char_at(undo,0) == 'c')
    {
    //clear frame, unused
    ds_list_copy(ds_list_find_index(controller.frame_list,real(string_digits(ds_list_find_value(controller.undo_list,ds_list_size(controller.undo_list)-1)))),real(string_digits(undo)));
    ds_list_delete(controller.undo_list,ds_list_size(controller.undo_list)-1);
    }
else if (string_char_at(undo,0) == 'v')
    {
    controller.anicolor1 = real(string_digits(undo));
    controller.anicolor2 = real(string_digits(ds_list_find_value(controller.undo_list,ds_list_size(controller.undo_list)-1)));
    ds_list_delete(controller.undo_list,ds_list_size(controller.undo_list)-1);
    controller.anienddotscolor = real(string_digits(ds_list_find_value(controller.undo_list,ds_list_size(controller.undo_list)-1)));
    ds_list_delete(controller.undo_list,ds_list_size(controller.undo_list)-1);
    update_anicolors();
    }
else if (string_char_at(undo,0) == 'b')
    {
    controller.color1 = real(string_digits(undo));
    controller.color2 = real(string_digits(ds_list_find_value(controller.undo_list,ds_list_size(controller.undo_list)-1)));
    ds_list_delete(controller.undo_list,ds_list_size(controller.undo_list)-1);
    controller.enddotscolor = real(string_digits(ds_list_find_value(controller.undo_list,ds_list_size(controller.undo_list)-1)));
    ds_list_delete(controller.undo_list,ds_list_size(controller.undo_list)-1);
    update_colors();
    }
else if (string_char_at(undo,0) == 'k')
    {
    //undo reapply elements
    for (u = 0;u < ds_list_size(real(string_digits(undo)));u++)
        {
        list = ds_list_find_value(real(string_digits(undo)),u);
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
    }
else if (string_char_at(undo,0) == 'l')
    {
    //undo delete
    for (u = 0;u < ds_list_size(real(string_digits(undo)));u++)
        {
        list = ds_list_find_value(real(string_digits(undo)),u);
        tempid = ds_list_find_value(list,9);
        frame = ds_list_find_value(list,ds_list_size(list)-1);
        ds_list_delete(list,ds_list_size(list)-1);
        el_list = ds_list_find_value(controller.frame_list,frame);
        ds_list_add(el_list,list);
        }
    }
    
    
with (controller)
    {
    frame_surf_refresh = 1;
    update_semasterlist();
    }
