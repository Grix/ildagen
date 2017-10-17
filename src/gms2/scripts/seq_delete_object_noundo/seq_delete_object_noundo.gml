//delete timeline object, no undo
for (k = 0; k < ds_list_size(somaster_list); k++)
{
    for (c = 0; c < ds_list_size(layer_list); c++)
    {
        layerlisttemp = ds_list_find_value(ds_list_find_value(layer_list,c), 1);
        if (ds_list_find_index(layerlisttemp,ds_list_find_value(somaster_list,k)) != -1)    
        {
            objectlist = ds_list_find_value(somaster_list,k);
			if (!ds_exists(objectlist, ds_type_list))
			{
				ds_list_delete(somaster_list,k);
				if (k > 0)
					k--;
				break;
			}
            ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));
            infolist = objectlist[| 2];
        
            if (surface_exists(infolist[| 1]))
                surface_free(infolist[| 1]);
            
            if (buffer_exists(objectlist[| 1]))
                buffer_delete(objectlist[| 1]);
                
            selectedx = ds_list_find_value(objectlist,0);
            selectedlayer = c;
            ds_list_destroy(infolist);
            ds_list_destroy(objectlist);
        }
    }
}
    
ds_list_clear(somaster_list);
frame_surf_refresh = 1;
