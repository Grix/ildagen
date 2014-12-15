//export double FMODGroupSetVolume(double group, double volume)
//This set the group (1-4) volume. 0 for master. Changes are relative to the sound max volume and 
//the global volume

//You need to keep track of the groups volume yourself in variables 
//if you need to remember the volume of the each group
// overall = maxvalue*instancevalue*group*global*distancefactor

return external_call(global.dll_FMODGroupSetVolume,argument0,argument1);