function dd_seq_addfadein() {
	if (controller.use_bpm)
		seq_dialog_num("add_fadein", "Choose how long the fade-in should last (in number of beats):", controller.beats_per_bar); 
	else
		seq_dialog_num("add_fadein", "Choose how long the fade-in should last (in seconds):", 1); 


}
