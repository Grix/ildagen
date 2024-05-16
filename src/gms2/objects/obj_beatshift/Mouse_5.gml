if (instance_exists(obj_dropdown))
    exit;
	
if (!visible)
	exit;
	
seq_dialog_num("beats_shift","Enter the beat offset in number of beats",seqcontrol.beats_shift);

