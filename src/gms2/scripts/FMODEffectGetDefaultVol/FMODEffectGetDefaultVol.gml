//export double FMODEffectGetDefaultVol(double effect)
//This function gets the pan of the effect

//0 to 1 = FMODEffectGetDefaultVol(effect);

//returns the volume value

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetDefaultVol(effect,1)
//active = FMODEffectGetDefaultVol(effect)

//...
// //later
//FMODEffectFree(effect)

//Some effect can be have the volume changed (Have not found one that does though)


return external_call(global.dll_FMODEffectGetDefaultVol,argument0);
