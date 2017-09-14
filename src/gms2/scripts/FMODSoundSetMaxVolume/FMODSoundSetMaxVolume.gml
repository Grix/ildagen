//export double FMODSoundSetMaxVolume(double sound, double volume)

//returns 0 on error
//returns 1 on success

//volume is the volume 0 to 1

//Use this to define sound's max volume (default is 1)

//The sound will never be louder than this value
//Other volume controls exist in the game, the global, the group and the distance (if 3d)
//the overall volume is a combination of all of those
// overall = maxvalue*instancevalue*group*global*distancefactor

//sound = FMODSoundAdd("gunshot.wav");
//FMODSoundSetMaxVolume(sound,.5);

//Call before playing the sound

return external_call(global.dll_FMODSoundSetMaxVolume,argument0,argument1);
