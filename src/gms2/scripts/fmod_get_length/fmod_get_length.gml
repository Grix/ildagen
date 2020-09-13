function fmod_get_length() {
	//@param sound
	gml_pragma("forceinline");
	return FMODGMS_Util_SamplesToSeconds( FMODGMS_Snd_Get_Length(argument[0]), seqcontrol.song_samplerate)*1000;

	//in ms


}
