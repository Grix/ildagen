//export double FMODGroupStop(double group)

//This stops a group and frees all instances used by it.

//Call this when the room ends FMODAllStop is the same as group 0 

return external_call(global.dll_FMODGroupStop,argument0);