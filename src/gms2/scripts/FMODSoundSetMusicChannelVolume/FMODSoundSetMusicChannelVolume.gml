//export double FMODSoundSetMusicChannelVolume(double sound, double channel, double volume)
//Set the volume (0 to 1) for a channel for MOD/S3M/XM/IT/MIDI sounds. 
//A Music channel is basically an instrument in a midi file
//channel specifies the midi instrument track you want to get the volume for.

//Use with FMODSoundGetMusicNumChannels to be sure not to ask for a channel that does not exist

return external_call(global.dll_FMODSoundSetMusicChannelVolume,argument0, argument1, argument2);
