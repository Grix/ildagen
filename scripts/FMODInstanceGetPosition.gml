//export double FMODInstanceGetPosition(double instance)

//Returns the current play position (0 - start, 1 is end, .5 is middle) of the music
return external_call(global.dll_FMODInstanceGetPosition,argument0);
