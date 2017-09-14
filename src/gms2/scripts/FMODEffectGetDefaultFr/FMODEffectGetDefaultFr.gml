//export double FMODEffectGetDefaultFr(double effect)
//This function gets the frequency of the effect

//-1(left) to 1 right = FMODEffectGetDefaultFr(effect);

//returns the frequency value

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetDefaultFr(effect,1)
//fr = FMODEffectGetDefaultFr(effect)

//...
// //later
//FMODEffectFree(effect)

//Have not tried this... 
//Expect same as pan and vol


return external_call(global.dll_FMODEffectGetDefaultFr,argument0);
