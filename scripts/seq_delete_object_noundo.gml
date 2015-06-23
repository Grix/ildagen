//delete timeline object
layerlisttemp = ds_list_find_value(layer_list,selectedlayer);
frametimetemp = ds_list_find_value(layerlisttemp,abs(selectedx));

repeat (3) ds_list_delete(layerlisttemp,abs(selectedx));

selectedx = frametimetemp;
