//export double FMODEffectGetParamDesc(double effect, double p)
//This function gets the parameter description of the effect in a string 

//n = FMODEffectGetParamDesc(effect,0);

//returns the description of the parameter

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//desc = FMODEffectGetParamDesc(effect,1)

//...
// //later
//FMODEffectFree(effect)
var s;
s = string_repeat(chr(0),257)
external_call(global.dll_FMODEffectGetParamDesc,argument0, argument1,s);
return s;
