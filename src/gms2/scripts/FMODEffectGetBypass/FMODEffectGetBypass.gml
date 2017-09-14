//export double FMODEffectGetBypass(double effect)
//This function checks if the effect is bypassed

//true/false = FMODEffectGetBypass(effect);

//returns 0 on error or not active
//return 1 if active 

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetBypass(effect,false)
//active = FMODEffectGetBypass(effect)

//...
// //later
//FMODEffectFree(effect)

//You can deactivate effects instead of freeing them this whay you don't have to recreate it
//If you add multiple effect to a sound the effect are cumulative wich is usually what you want
//Removing the effect would cause the chain of effects to be changed and re-creating the effect
//would put it back but at the end of the chain. 

return external_call(global.dll_FMODEffectGetBypass,argument0);
