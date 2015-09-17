//export double FMODSoundSetLoopCount(double sound, double count)

//returns 0 on error
//returns 1 on success

//Sets how many times a sound will be looped when played
//Same as FMODInstanceSetLoopCount but affect all instances created after


//Call before playing the sound

return external_call(global.dll_FMODSoundSetLoopCount,argument0,argument1);
