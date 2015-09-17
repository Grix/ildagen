//export double FMODInstanceGetFrequency(double instance)

//Set a playing instance frequency fro "bullet time" effect
//some sounds can have negative freq, reversed/rewinding effect if not streamed

//returns the frequency of the instance or 0 on error
//sound = FMODSoundAdd("test.mp3");
//instance= FMODSoundLoop(sound);
//fr = FMODInstanceGetFrequency(instance,FMODInstanceGetFrequency(instance)/2);
return external_call(global.dll_FMODInstanceGetFrequency,argument0);
