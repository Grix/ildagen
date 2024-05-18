function dd_seq_addstrobe() {
	if (controller.use_bpm)
		seq_dialog_num("add_strobe", "Choose the period of strobing (flashing the laser on and off repeatedly) in number of beats:", 1); 
	else
		seq_dialog_num("add_strobe", "Choose the period of strobing (flashing the laser on and off repeatedly) in seconds:", 0.1); 

}
