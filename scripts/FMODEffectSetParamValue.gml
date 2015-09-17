//export double FMODEffectSetParamValue(double effect, double p, double v)
//This function set the parameter value of the effect to the value specified (v)

//n = FMODEffectGetParamValue(effect,0);

//returns the value of effect parameters

//each effect have different parameter that have different ranges in values
//You can figure out the parameter id and values in the demo

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//FMODEffectSetParamValue(effect,1,.5)

//...
// //later
//FMODEffectFree(effect)

return external_call(global.dll_FMODEffectSetParamValue,argument0, argument1, argument2);
