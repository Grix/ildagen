//export double FMODEffectFree(double effect)
//This function stops and frees an effect from memory

//FMODEffectFree(effect);
//effect = 0; //this prevents from accidently using the effect

//returns 0 on error (sound is being played by an instance)
//return 1 on success 

//sound = FMODSoundAdd("gunshot.wav")
//FMODSoundSetGroup(sound,1);
//effect = FMODGroupAddEffect(1, 5);
//instance = FMODSoundPlay(sound);
//effect2 = FMODInstanceAddEffect(instance, 3);

//...
// //later
//FMODEffectFree(effect)
//FMODEffectFree(effect2)

return external_call(global.dll_FMODEffectFree,argument0);
