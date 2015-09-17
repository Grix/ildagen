//export double FMODInstanceGetAudibility(double instance)
//returns the audibility of the sound instance
//to determine if the instance can be heard over the speakers

return external_call(global.dll_FMODInstanceGetAudibility,argument0);
