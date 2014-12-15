//export double FMODInstanceIsPlaying(double instance)

//Retuns 1 if the sound instance is playing
//Returns 0 if not playing or error (an error can happen if the instance is no longer valid but you get 0 in this case)

//Example to free a sound when it's done playing (for a single play once temporary sound)
//which is useful to do
//if(!FMODInstanceIsPlaying(instance))
//{ 
//    FMODSoundFree(sound);
//    sound = 0;
//}

return external_call(global.dll_FMODInstanceIsPlaying,argument0);