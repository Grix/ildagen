function projector_rename() {
	var t_thisprojlist = seqcontrol.layer_list[| settingscontrol.projectortoselect];

	seq_dialog_string("layer_rename","Enter a new name for the layer:",t_thisprojlist[| 4]);



}
