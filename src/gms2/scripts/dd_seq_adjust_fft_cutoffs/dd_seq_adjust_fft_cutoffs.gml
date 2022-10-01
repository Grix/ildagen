function dd_seq_adjust_fft_cutoffs() {
	seq_dialog_num("fft_cutoff_bass_low", "Enter lower bass window cutoff (range 0-2048, default 0)", seqcontrol.audio_fft_bass_low_cutoff);
}
