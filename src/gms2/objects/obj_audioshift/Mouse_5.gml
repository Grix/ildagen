if (instance_exists(obj_dropdown))
    exit;
	
if (!visible)
	exit;
	
seq_dialog_num("audioshift","Enter the audio offset in milliseconds",seqcontrol.audioshift);

