//export double FMODInstanceSetFrequency(double instance, double freq)

//Set a playing instance frequency fro "bullet time" effect
//some sounds can have negative freq, reversed/rewinding effect if not streamed
//sound = FMODSoundAdd("test.mp3");
//instance= FMODSoundLoop(sound);
//FMODInstanceSetFrequency(instance,FMODInstanceGetFrequency(instance)/2);
//Use FMODInstanceGetFrequency(instance); to get to original frequency before changing it
//so to reset the frequency when done with your effect
//44100 is usually the normal frequency 
//See FMODGroupSetFrequency for changing many sounds at the same time
return external_call(global.dll_FMODInstanceSetFrequency,argument0,argument1);
