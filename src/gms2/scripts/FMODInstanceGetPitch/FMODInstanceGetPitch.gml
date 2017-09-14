//export double FMODInstanceGetPitch(double instance)

//Set the instance pitch. 0 to 10, 1 is default
//some sounds can have negative pitch, reversed/rewinding effect if not streamed

//See Also FMODInstanceSetPitch/Frequency
return external_call(global.dll_FMODInstanceGetPitch,argument0);
