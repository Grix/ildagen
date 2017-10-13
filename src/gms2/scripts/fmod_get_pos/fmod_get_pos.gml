//@param channel
gml_pragma("forceinline");
return FMODGMS_Util_SamplesToSeconds( FMODGMS_Chan_Get_Position(argument[0]), seqcontrol.song_samplerate)*1000;