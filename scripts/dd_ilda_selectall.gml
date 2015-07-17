ds_list_clear(semaster_list);

for (i = 0;i < ds_list_size(el_list); i++)
    {
    templist = ds_list_find_value(el_list,i);
    ds_list_add(semaster_list,ds_list_find_value(templist,9));
    }
    
controller.update_semasterlist_flag = 1;