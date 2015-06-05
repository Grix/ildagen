//cut timeline object
layerlisttemp = ds_list_find_value(layer_list,selectedlayer);
copy_list = ds_list_find_value(layerlisttemp,abs(selectedx)+2); //infolist

repeat (3) ds_list_delete(layerlisttemp,abs(selectedx));

selectedx = abs(selectedx);
