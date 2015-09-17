//export double FMODEffectGetNumParams(double effect)
//This function gets the number of parameters of the effect

//n = FMODEffectGetNumParams(effect);

//returns the numebr of parameters

//You dont really need this if you know (using the demo)
//  the parameter id of the parameter you want to change

//sound = FMODSoundAdd("gunshot.wav")
//instance = FMODSoundPlay(sound);
//effect = FMODInstanceAddEffect(instance, 3);
//numeff = FMODEffectGetNumParams(effect)

//...
// //later
//FMODEffectFree(effect)

return external_call(global.dll_FMODEffectGetNumParams,argument0);
