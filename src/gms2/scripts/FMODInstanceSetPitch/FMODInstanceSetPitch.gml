//export double FMODInstanceSetPitch(double instance, double pitch)

//Set the instance pitch. 0 to 10, 1 is default
//some sounds can have negative pitch, reversed/rewinding effect if not streamed

//See Also FMODInstanceGetPitch/Frequency
return external_call(global.dll_FMODInstanceSetPitch,argument0,argument1);
