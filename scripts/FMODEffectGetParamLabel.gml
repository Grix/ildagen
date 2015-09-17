//export double FMODEffectGetParamLabel(double effect, double p)
//This function gets the parameter label in a string 

//n = FMODEffectGetParamValueStr(effect,0);

//returns the label of the parameters

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//lb= FMODEffectGetParamLabel(effect,1)

//...
// //later
//FMODEffectFree(effect)
var s;
s = string_repeat(chr(0),20)
external_call(global.dll_FMODEffectGetParamLabel,argument0, argument1,s);
return s;
