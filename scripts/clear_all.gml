ilda_cancel();
ds_list_clear(semaster_list);

for (j = 0;j < ds_list_size(frame_list);j++)
{
    el_list = ds_list_find_value(frame_list,j);
    for (i = 0;i < ds_list_size(el_list);i++)
    {
        list_id = ds_list_find_value(el_list,i);
        ds_list_destroy(list_id);
    }
    ds_list_destroy(el_list);
}
ds_list_destroy(frame_list);

frame_list = ds_list_create();
el_list = ds_list_create();
ds_list_add(frame_list,el_list);

//clear undo
while (ds_list_size(undo_list))
{
    undo = ds_list_find_value(undo_list,0);
    ds_list_delete(undo_list,0);

    if (is_real(undo))
    {
        //nothing
    }
    else if (string_char_at(undo,0) == 'a')
    {
        //nothing
    }
    else if (string_char_at(undo,0) == 'r')
    {
        //nothing
    }
    else if (string_char_at(undo,0) == 'd')
    {
        //nothing
    }
    else if (string_char_at(undo,0) == 'v')
    {
        if (!ds_exists(real(string_digits(undo)),ds_type_list))
            continue;
        ds_list_destroy(real(string_digits(undo)));
    }
    else if (string_char_at(undo,0) == 'b')
    {
        if (!ds_exists(real(string_digits(undo)),ds_type_list))
            continue;
        ds_list_destroy(real(string_digits(undo)));
    }
    else if (string_char_at(undo,0) == 'k')
    {
        //undo reapply elements
        if (!ds_exists(real(string_digits(undo)),ds_type_list))
            continue;
        tempundolist = real(string_digits(undo));
        for (u = 0;u < ds_list_size(tempundolist)-1;u++)
        {
            list = ds_list_find_value(tempundolist,u);
            ds_list_destroy(list);
        }
        ds_list_destroy(tempundolist);
    }
    else if (string_char_at(undo,0) == 'l')
    {
        //undo delete
        if (!ds_exists(real(string_digits(undo)),ds_type_list))
            continue;
        tempundolist = real(string_digits(undo));
        for (u = 0;u < ds_list_size(tempundolist)-1;u++)
        {
            list = ds_list_find_value(tempundolist,u);
            ds_list_destroy(list);
        }
        ds_list_destroy(tempundolist);
    }
}
ds_list_destroy(undo_list);
undo_list = ds_list_create();

framepoints = 0;
frame = 0;
framehr = 0;
maxframes = 1;
scope_start = 0;
scope_end = maxframes-1;
refresh_miniaudio_flag = 1;
if (laseron)
{
    laseron = false;
    dac_blank_and_center(dac);
}


frame_surf_refresh = 1;

