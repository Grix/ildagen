//export double FMODSoundGetMusicChannelVolume(double sound, double channel)
//Retrieves volume (0 to 1) of a channel for MOD/S3M/XM/IT/MIDI sounds. 
//A Music channel is basically an instrument in a midi file
//channel specifies the midi instrument track you want to get the volume for.


//Use with FMODSoundGetMusicNumChannels to be sure not to ask for a channel that does not exist

return external_call(global.dll_FMODSoundGetMusicChannelVolume,argument0,argument1);
