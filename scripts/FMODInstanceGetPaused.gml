//export double FMODInstanceGetPaused(double instance)

//Get the instance paused setting. It must be playing (valid) or you will get 0

return external_call(global.dll_FMODInstanceGetPaused,argument0);
