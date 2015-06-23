//delete timeline object
layerlisttemp = ds_list_find_value(layer_list,selectedlayer);

frametimetemp = ds_list_find_value(layerlisttemp,abs(selectedx));

undolisttemp = ds_list_create();

ds_list_add(undolisttemp,frametimetemp); //frametime
ds_list_add(undolisttemp,ds_list_find_value(layerlisttemp,abs(selectedx)+2)); //infolist
ds_list_add(undolisttemp,selectedlayer); //layer
ds_list_add(undolisttemp,ds_list_find_value(layerlisttemp,abs(selectedx)+1)); //buffer
ds_list_add(undo_list,"d"+string(undolisttemp));

repeat (3) ds_list_delete(layerlisttemp,abs(selectedx));

selectedx = frametimetemp;
