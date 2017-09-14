//export double FMODEffectGetDefaultPan(double effect)
//This function gets the pan of the effect

//-1(left) to 1 right = FMODEffectGetDefaultPan(effect);

//returns the pan value

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetDefaultPan(effect,1)
//active = FMODEffectGetDefaultPan(effect)

//...
// //later
//FMODEffectFree(effect)

//Some effect can be panned (Have not found one that does though)

return external_call(global.dll_FMODEffectGetDefaultPan,argument0);
