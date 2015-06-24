//delete timeline object, no undo
layerlisttemp = ds_list_find_value(layer_list,selectedlayer);

objectlist = abs(selectedx);

ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));

infolist = ds_list_find_value(objectlist, 2);

if (surface_exists(ds_list_find_value(infolist,1)))
    surface_free(ds_list_find_value(infolist,1));

//if buffer exists
    buffer_delete(ds_list_find_value(objectlist,1));
    
selectedx = ds_list_find_value(objectlist,0);

ds_list_destroy(infolist);
ds_list_destroy(objectlist);
