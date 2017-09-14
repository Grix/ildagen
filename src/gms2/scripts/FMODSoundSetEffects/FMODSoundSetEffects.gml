//export double FMODSoundSetEffects(double sound, double effects)

//adds sound effects to the sound, just like GM
//sound = FMODSoundAdd("gunshot.wav")
//FMODSoundSetEffects(sound, se_flanger | se_reverb);
//Action cannot be undone and you should not call this while an 
//instance of the sound exists
//You should only call this once per sound

//The same constants as GM are used to make it easy though not all effect will be exactly the same as in GM
//se_chorus
//se_compressor (no effect)
//se_echo
//se_equalizer (not the same as GM. FMOD_DSP_TYPE_HIGHPASS used) Adds more trebble 
//se_flanger
//se_reverb (not as strong a reverb as GM)
//se_gargle (not the same as GM. FMOD_DSP_TYPE_DISTORTION used)
//se_none

//Call before playing the sound


return external_call(global.dll_FMODSoundSetEffects,argument0,argument1);
