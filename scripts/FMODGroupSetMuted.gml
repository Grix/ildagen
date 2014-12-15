//export double FMODGroupSetMuted(double group, double mute)
//Mutes/unmutes the specified group (1-4) does not affect individual settings of instances
return external_call(global.dll_FMODGroupSetMuted,argument0,argument1);