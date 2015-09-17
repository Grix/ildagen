//export double FMODSoundGetNumChannels(double sound)
//returns 0 on error
//returns the number of channels of the sound 1 for mono, 2 stereo 4 for quatro...

return external_call(global.dll_FMODSoundGetNumChannels,argument0);
