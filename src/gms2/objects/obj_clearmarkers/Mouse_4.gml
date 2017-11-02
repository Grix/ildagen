if (instance_exists(obj_dropdown))
    exit;
if (!_visible) 
	exit;

ds_list_add(seqcontrol.undo_list,"l"+string(seqcontrol.marker_list));
seqcontrol.marker_list = ds_list_create();

