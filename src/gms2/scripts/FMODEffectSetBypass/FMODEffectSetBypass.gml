//export double FMODEffectSetBypass(double effect, double bypass)
//This function disables the effect without turning off the playing chain

//FMODEffectSetBypass(effect, true/false); //true means OFF realy

//return 1 if success 

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetBypass(effect,false)
//active = FMODEffectGetBypass(effect)

//...
// //later
//FMODEffectFree(effect)

//You can deactivate effects instead of freeing them this way you don't have to recreate it
//If you add multiple effect to a sound the effect are cumulative which is usually what you want
//Removing the effect would cause the chain of effects to be changed and re-creating the effect
//would put it back but at the end of the chain.  So use this to deactivate the effect

return external_call(global.dll_FMODEffectSetBypass,argument0, argument1);
