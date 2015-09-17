//export double FMODEffectGetParamMin(double effect, double p)
//This function gets the parameter min value of the effect

//n = FMODEffectGetParamMin(effect,0);

//returns the min value of effect parameters

//each effect have different parameter that have different ranges in values
//You can figure out the parameter id and values in the demo


//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//vmin = FMODEffectGetParamMin(effect,1)

//...
// //later
//FMODEffectFree(effect)

return external_call(global.dll_FMODEffectGetParamMin,argument0, argument1);
