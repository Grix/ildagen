//export double FMODInstanceGetSound(double instance)

//Get the sound the instance is playing. It must be playing (valid) or you will get 0

//sound = FMODInstanceGetSound(instance);
return external_call(global.dll_FMODInstanceGetSound,argument0);
