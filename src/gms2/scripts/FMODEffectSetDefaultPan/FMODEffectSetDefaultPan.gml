//export double FMODEffectSetDefaultPan(double effect, double pan)
//This function gets the pan of the effect

//success = FMODEffectSetDefaultPan(effect, -1 to 1);

//returns 0 on error
//return 1 on success

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetDefaultPan(effect,1)
//active = FMODEffectGetDefaultPan(effect)

//...
// //later
//FMODEffectFree(effect)

//Some effect can be panned (Have not found one that does though)


return external_call(global.dll_FMODEffectSetDefaultPan,argument0,argument1);
