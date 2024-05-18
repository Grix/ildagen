function dd_seq_addfadeout() {
	if (controller.use_bpm)
		seq_dialog_num("add_fadeout", "Choose how long the fade-out should last (in number of beats):", controller.beats_per_bar); 
	else
		seq_dialog_num("add_fadeout", "Choose how long the fade-out should last (in seconds):", 1); 


}
