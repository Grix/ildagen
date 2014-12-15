//export double FMODGroupSetPaused(double group, double pause)
//Pause/Unpause a group (1-4). does not affect individual settings of instances

return external_call(global.dll_FMODGroupSetPaused,argument0,argument1);