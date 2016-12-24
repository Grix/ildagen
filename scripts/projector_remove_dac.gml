var t_thisdaclist = ds_list_find_value(seqcontrol.projector_list[| settingscontrol.projectortoselect], 2);
ds_list_delete(t_thisdaclist, settingscontrol.dactoselect);

projectorlist_update();
