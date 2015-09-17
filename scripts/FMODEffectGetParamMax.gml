//export double FMODEffectGetParamMax(double effect, double p)
//This function gets the parameter max value of the effect

//n = FMODEffectGetParamMax(effect,0);

//returns the max value of effect parameters

//each effect have different parameter that have different ranges in values
//You can figure out the parameter id and values in the demo


//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//vmax = FMODEffectGetParamMax(effect,1)

//...
// //later
//FMODEffectFree(effect)

return external_call(global.dll_FMODEffectGetParamMax,argument0, argument1);
