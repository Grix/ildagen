//export double FMODEffectGetParamValue(double effect, double p)
//This function gets the parameter value of the effect

//n = FMODEffectGetParamValue(effect,0);

//returns the value of effect parameters

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//v = FMODEffectGetParamValue(effect,1)

//...
// //later
//FMODEffectFree(effect)

return external_call(global.dll_FMODEffectGetParamValue,argument0, argument1);
