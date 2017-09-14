//export double FMODEffectSetActive(double effect, double active)
//This function sets the effect active or disabled

//FMODEffectSetActive(effect, true/false);

//return 1 if success 

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetActive(effect,false)
//active = FMODEffectGetActive(effect)

//...
// //later
//FMODEffectFree(effect)

//Use the Bypass method. this actually stops the sound instance from playing

return external_call(global.dll_FMODEffectSetActive,argument0, argument1);
