//export double FMODGroupGetVolume(double group)

//This gets the group volume 0-Master (Global), 1-priority, 2-seefect, 3-ambientmusic, 4-ambient effects

return external_call(global.dll_FMODGroupGetVolume,argument0);