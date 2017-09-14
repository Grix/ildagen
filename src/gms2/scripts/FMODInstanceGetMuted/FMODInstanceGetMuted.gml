//export double FMODInstanceGetMuted(double instance)

//Get the instance mute setting. It must be playing (valid) or you will get 0

return external_call(global.dll_FMODInstanceGetMuted,argument0);
