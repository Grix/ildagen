//export double FMODGroupGetPitch(double group)


//This gets the group pitch (0-10, 1 default) groups: 0-Master (Global), 1-priority, 2-effects, 3-ambientmusic, 4-ambient effects

return external_call(global.dll_FMODGroupGetPitch,argument0);