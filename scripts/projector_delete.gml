var t_thisplist = seqcontrol.projector_list[| settingscontrol.projectortoselect];

var t_thisdaclist = t_thisplist[| 2];
for (i = 0; i < ds_list_size(t_thisdaclist); i++)
    ds_list_destroy(t_thisdaclist[| i]);
ds_list_destroy(t_thisdaclist);

ds_list_delete(seqcontrol.projector_list, settingscontrol.projectortoselect);
ds_list_destroy(t_thisplist);

projectorlist_update();
