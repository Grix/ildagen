//delete timeline object
layerlisttemp = ds_list_find_value(layer_list,selectedlayer);

frametimetemp = ds_list_find_value(layerlisttemp,abs(selectedx));

ds_list_add(undo_list,"dd"+string(frametimetemp)); //frametime
ds_list_add(undo_list,"dd"+string(ds_list_find_value(layerlisttemp,abs(selectedx)+2))); //infolist
ds_list_add(undo_list,"d"+string(selectedlayer)); //layer

repeat (3) ds_list_delete(layerlisttemp,abs(selectedx));

selectedx = frametimetemp;
