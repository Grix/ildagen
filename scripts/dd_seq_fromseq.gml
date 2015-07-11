if ((seqcontrol.selectedlayer == -1) or (seqcontrol.selectedx >= 0)) exit;

seq_dialog_yesno("fromseq","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");