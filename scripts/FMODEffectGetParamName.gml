//export double FMODEffectGetParamName(double effect, double p)
//This function gets the parameter name in a string 

//n = FMODEffectGetParamName(effect,0);

//returns the value of effect parameters

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//nm = FMODEffectGetParamName(effect,1)

//...
// //later
//FMODEffectFree(effect)
var s;
s = string_repeat(chr(0),20)
external_call(global.dll_FMODEffectGetParamName,argument0, argument1,s);
return s;
