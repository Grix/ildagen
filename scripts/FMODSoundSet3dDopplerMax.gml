//export double FMODSoundSet3dDopplerMax(double sound, double dopplerval)
//Call this to set the sound doppler setting

//doppler settings 0 to 5) 0 - none 1 - normal, 5 is maximum
//This turns off doppler for this sound
//sound = FMODSoundAdd("sound.wav",true);
//FMODSoundSet3dDopplerMax(sound,0);
//Sound must be 3d

//FMODSetDopplerFPS(room_speed) must have been called for doppler to work 
return external_call(global.dll_FMODSoundSet3dDopplerMax,argument0,argument1);