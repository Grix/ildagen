if (copy_list == -1)
    exit;
    
ds_list_clear(semaster_list);

var tempelid = -1;

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
        show_debug_message(framei)
        continue;
        }
    
    ds_list_replace(list,0,ds_list_find_value(list,0)+2500);
    ds_list_replace(list,1,ds_list_find_value(list,1)+2500);
    ds_list_replace(list,2,ds_list_find_value(list,2)+2500);
    ds_list_replace(list,3,ds_list_find_value(list,3)+2500);
    ds_list_delete(list,ds_list_size(list)-1);
    
    if (tempelid != ds_list_find_value(list,9))
        {
        show_debug_message(el_id)
        el_id++;
        ds_list_add(semaster_list,el_id);
        tempelid = ds_list_find_value(list,9);
        ds_stack_push(undo_list,el_id);
        }
    ds_list_replace(list,9,el_id);
    el_list = ds_list_find_value(frame_list,framei);
    ds_list_add(el_list,list);
    }

update_semasterlist();
frame_surf_refresh = 1;
