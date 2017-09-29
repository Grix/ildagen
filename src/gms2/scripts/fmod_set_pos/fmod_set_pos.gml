//@param channel
//@param pos(ms)
return FMODGMS_Chan_Set_Position(argument[0], FMODGMS_Util_SecondsToSamples( argument[1]/1000, song_samplerate));