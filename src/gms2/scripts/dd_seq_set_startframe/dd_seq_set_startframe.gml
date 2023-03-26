function dd_seq_set_startframe() {
	seqcontrol.startframe = round(seqcontrol.tlpos/1000*seqcontrol.projectfps);

}
