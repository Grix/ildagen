//export double FMODEffectSetDefaultVol(double effect, double vol)
//This function gets the pan of the effect

//success = FMODEffectGetDefaultVol(effect, 0 to 1);

//returns 0 on error, 1 on success

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetDefaultVol(effect,1)
//active = FMODEffectGetDefaultVol(effect)

//...
// //later
//FMODEffectFree(effect)

//Some effect can be have the volume changed (Have not found one that does though)



return external_call(global.dll_FMODEffectSetDefaultVol,argument0, argument1);
