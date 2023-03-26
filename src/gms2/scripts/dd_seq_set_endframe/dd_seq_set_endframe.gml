function dd_seq_set_endframe() {
	seqcontrol.endframe = round(seqcontrol.tlpos/1000*seqcontrol.projectfps);

}
