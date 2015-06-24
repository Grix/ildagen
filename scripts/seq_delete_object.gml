//delete timeline object
layerlisttemp = ds_list_find_value(layer_list,selectedlayer);

objectlist = abs(selectedx);

undolisttemp = ds_list_create();
ds_list_add(undolisttemp,layerlisttemp);
ds_list_add(undolisttemp,objectlist);
ds_list_add(undo_list,"d"+string(undolisttemp));

ds_list_delete(layerlisttemp,ds_list_find_index(layerlisttemp,objectlist));

selectedx = ds_list_find_value(objectlist,0);
