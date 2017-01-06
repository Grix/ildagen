var t_daclist = ds_list_find_value(seqcontrol.layer_list[| settingscontrol.projectortoselect], 5);
ds_list_replace(t_daclist[| settingscontrol.dactoselect], 2, argument[0]-1);

projectorlist_update();
