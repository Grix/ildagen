//@param channel
//@param pos(ms)
gml_pragma("forceinline");
return FMODGMS_Chan_Set_Position(argument[0], FMODGMS_Util_SecondsToSamples( argument[1]/1000, seqcontrol.song_samplerate));