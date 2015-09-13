//delete timeline object, no undo
for (k = 0; k < ds_list_size(somaster_list); k++)
    {
    for (c = 0; c < ds_list_size(layer_list); c++)
        {
        layerlisttemp = ds_list_find_value(layer_list,c);
        if (ds_list_find_index(layerlisttemp,ds_list_find_value(somaster_list,k)) != -1)    
            {
            objectlist = ds_list_find_value(somaster_list,k);
            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
            infolist = ds_list_find_value(objectlist, 2);
        
            if (surface_exists(ds_list_find_value(infolist,1)))
                surface_free(ds_list_find_value(infolist,1));
            
            //if buffer exists
                buffer_delete(ds_list_find_value(objectlist,1));
                
            selectedx = ds_list_find_value(objectlist,0);
            selectedlayer = c;
            ds_list_destroy(infolist);
            ds_list_destroy(objectlist);
            }
        }
    }
    
ds_list_clear(somaster_list);
frame_surf_refresh = 1;