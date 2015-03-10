if (copy_list == -1)
    exit;
    
changese = 0;
for (u = 0;u < ds_list_size(copy_list);u++)
    {
    list = ds_list_create();
    ds_list_copy(list,ds_list_find_value(copy_list,u));
    if (u == 0)
        firstframe = ds_list_find_value(list,ds_list_size(list)-1);
    framei = frame+ds_list_find_value(list,ds_list_size(list)-1)-firstframe;
    if (framei > maxframes-1)
        {
        ds_list_destroy(list);
        break;
        }
    if (frame == framei)
        {
        changese = 1;
        selectedelementlist = list;
        }
    ds_list_delete(list,ds_list_size(list)-1);
    ds_list_replace(list,9,el_id);
    el_list = ds_list_find_value(frame_list,framei);
    show_debug_message(framei);
    ds_list_add(el_list,list);
    }    
    
if (changese)
    selectedelement = el_id;
ds_stack_push(undo_list,el_id);
el_id++;

ds_list_replace(selectedelementlist,0,ds_list_find_value(selectedelementlist,0)+2500);
ds_list_replace(selectedelementlist,1,ds_list_find_value(selectedelementlist,1)+2500);
ds_list_replace(selectedelementlist,2,ds_list_find_value(selectedelementlist,2)+2500);
ds_list_replace(selectedelementlist,3,ds_list_find_value(selectedelementlist,3)+2500);

if (changese)
    {
    xo = ds_list_find_value(selectedelementlist,0)/$ffff*512;
    yo = ds_list_find_value(selectedelementlist,1)/$ffff*512;
    rectxmin = xo + (ds_list_find_value(selectedelementlist,4));
    rectymin = yo + (ds_list_find_value(selectedelementlist,6));
    rectxmax = xo + (ds_list_find_value(selectedelementlist,5));
    rectymax = yo + (ds_list_find_value(selectedelementlist,7));
    }

frame_surf_refresh = 1;