//export double FMODEffectSetDefaultFr(double effect, double frequency)
//This function gets the frequency of the effect

//success = FMODEffectSetDefaultFr(effect, -1 to 1);

//returns 0 on error
//return 1 on success

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetDefaultFr(effect,1)
//active = FMODEffectGetDefaultFr(effect)

//...
// //later
//FMODEffectFree(effect)

//Have not tried this... 
//Expect same as pan and vol


return external_call(global.dll_FMODEffectSetDefaultFr,argument0,argument1);
