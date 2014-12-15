//export double FMODSoundGetLoopCount(double sound)

//returns the loops count set for the sound

//NOT the Same as FMODInstanceGetLoopCount 
//This ALWAYS returns the Loop Count that was set for the sound

return external_call(global.dll_FMODSoundGetLoopCount,argument0);