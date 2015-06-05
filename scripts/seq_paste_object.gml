//paste timeline object

infolisttemp = copy_list;

layerlisttemp = ds_list_find_value(layer_list,selectedlayer);
ds_list_add(layerlisttemp,selectedx);
ds_list_add(layerlisttemp,-1);
ds_list_add(layerlisttemp,infolisttemp);

frame_surf_refresh = 1;

//TODO UNDO
