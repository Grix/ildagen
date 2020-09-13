function layer_delete() {
	layertodelete = ds_list_find_value(layer_list,selectedlayer);
	seq_dialog_yesno("layerdelete","Are you sure you want to delete this layer? (Cannot be undone)");



}
