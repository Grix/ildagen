function seq_edit_object() {
	//send object to frames editor
	if (!controller.warning_disable)
		seq_dialog_yesno("fromseq","You are about to open the selected object in the editor mode. This will discard any unsaved changes currently in the editor. Continue? (Cannot be undone)");
	else
		with (seqcontrol)
			frames_fromseq();

}
