//export double FMODEffectGetActive(double effect)
//This function checks if the effect is active

//true/false = FMODEffectGetActive(effect);

//returns 0 on error or not active
//return 1 if active 

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetActive(effect,false)
//active = FMODEffectGetActive(effect)

//...
// //later
//FMODEffectFree(effect)

//Use the Bypass method instead. 

return external_call(global.dll_FMODEffectGetActive,argument0);
