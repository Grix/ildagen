//export double FMODSoundGetMusicNumChannels(double sound)
//Retrieves number of music channel for MOD/S3M/XM/IT/MIDI sounds. 
//A Music channel is basically an instrument in a midi file

//Use with FMODSoundSet/GetMusicChannelVolume to be sure not to ask for a channel that does not exist

return external_call(global.dll_FMODSoundGetMusicNumChannels,argument0);
