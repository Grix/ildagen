var t_undolist = ds_list_create();
var t_list1 = ds_list_create();
var t_list2 = ds_list_create();
ds_list_copy(t_list1,ds_list_find_value(seqcontrol.selectedenvelope,1));
ds_list_copy(t_list2,ds_list_find_value(seqcontrol.selectedenvelope,2));
ds_list_add(t_undolist,t_list1);
ds_list_add(t_undolist,t_list2);
ds_list_add(t_undolist,seqcontrol.selectedenvelope);
ds_list_add(seqcontrol.undo_list,"e"+string(t_undolist));
ds_list_clear(ds_list_find_value(seqcontrol.selectedenvelope,1));
ds_list_clear(ds_list_find_value(seqcontrol.selectedenvelope,2));
seqcontrol.timeline_surf_length = 0;