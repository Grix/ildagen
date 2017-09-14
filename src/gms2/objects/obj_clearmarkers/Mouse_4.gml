if (instance_exists(oDropDown))
    exit;
if (!visible) exit;

ds_list_add(seqcontrol.undo_list,"l"+string(seqcontrol.marker_list));
seqcontrol.marker_list = ds_list_create();

