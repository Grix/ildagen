//export double FMODSoundSet3dMinMaxDistance(double sound, double Min, double Max)
//returns 0 on error
//returns 1 on success

//Use this to define the sound travelling distance on for 3d sounds

//Min specifies the radius (in pixel, usually) where the sound is maximum
//Max specifies the radius where the sound is no longer heard
//the sound fades between min and max

//Sound must be 3d
//sound = FMODSoundAdd("gunshot.wav",true);
//FMODSoundSet3dMinMaxDistance(sound,100,500);

//you cannot call this while a sound instance is playing

//Call before playing the sound

return external_call(global.dll_FMODSoundSet3dMinMaxDistance,argument0,argument1,argument2);
