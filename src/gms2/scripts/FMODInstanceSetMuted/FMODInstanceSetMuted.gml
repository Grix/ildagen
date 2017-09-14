//export double FMODInstanceSetMuted(double instance, double mute)

//Mutes the specified instance but does not stop it
//if the group or all is muted, it will unmute when the group and all are unmuted
//returns 1 on success or 0 on error
//mute - set to true or false to mute and unmute

return external_call(global.dll_FMODInstanceSetMuted,argument0,argument1);
