//export double FMODEffectGetParamValueStr(double effect, double p)
//This function gets the parameter value of the effect in a string 

//n = FMODEffectGetParamValueStr(effect,0);

//returns the value of effect parameters

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//vs = FMODEffectGetParamValueStr(effect,1)

//...
// //later
//FMODEffectFree(effect)
var s;
s = string_repeat(chr(0),20)
external_call(global.dll_FMODEffectGetParamValueStr,argument0, argument1,s);
return s;
