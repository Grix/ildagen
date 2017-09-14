//export double FMODSoundAddEffect(double sound, double effects, position)

//Adds an FMOD effect to a sound at the position (0-9) specified 
//Effects
//    FMOD_DSP_TYPE_MIXER,          1    /* This unit does nothing but take inputs and mix them together then feed the result to the soundcard unit. */
//    FMOD_DSP_TYPE_OSCILLATOR,     2    /* This unit generates sine/square/saw/triangle or noise tones. */
//    FMOD_DSP_TYPE_LOWPASS,        3    /* This unit filters sound using a high quality, resonant lowpass filter algorithm but consumes more CPU time. */
//    FMOD_DSP_TYPE_ITLOWPASS,      4    /* This unit filters sound using a resonant lowpass filter algorithm that is used in Impulse Tracker, but with limited cutoff range (0 to 8060hz). */
//    FMOD_DSP_TYPE_HIGHPASS,       5    /* This unit filters sound using a resonant highpass filter algorithm. */
//    FMOD_DSP_TYPE_ECHO,           6    /* This unit produces an echo on the sound and fades out at the desired rate. */
//    FMOD_DSP_TYPE_FLANGE,         7    /* This unit produces a flange effect on the sound. */
//    FMOD_DSP_TYPE_DISTORTION,     8    /* This unit distorts the sound. */
//    FMOD_DSP_TYPE_NORMALIZE,      9    /* This unit normalizes or amplifies the sound to a certain level. */
//    FMOD_DSP_TYPE_PARAMEQ,        10    /* This unit attenuates or amplifies a selected frequency range. */
//    FMOD_DSP_TYPE_PITCHSHIFT,     11    /* This unit bends the pitch of a sound without changing the speed of playback. */
//    FMOD_DSP_TYPE_CHORUS,         12    /* This unit produces a chorus effect on the sound. */
//    FMOD_DSP_TYPE_REVERB,         13    /* This unit produces a reverb effect on the sound. */
//    FMOD_DSP_TYPE_VSTPLUGIN,      14    /* This unit allows the use of Steinberg VST plugins */
//    FMOD_DSP_TYPE_WINAMPPLUGIN,   15    /* This unit allows the use of Nullsoft Winamp plugins */
//    FMOD_DSP_TYPE_ITECHO,         16    /* This unit produces an echo on the sound and fades out at the desired rate as is used in Impulse Tracker. */
//    FMOD_DSP_TYPE_COMPRESSOR,     17    /* This unit implements dynamic compression (linked multichannel, wideband) */
//    FMOD_DSP_TYPE_SFXREVERB,      18    /* This unit implements SFX reverb */
//    FMOD_DSP_TYPE_LOWPASS_SIMPLE, 19    /* This unit filters sound using a simple lowpass with no resonance, but has flexible cutoff and is fast. */


//I dont check if an effect exist at the specified position do be careful not to
//add an effect at the same position twice.
//sound = FMODSoundAdd("gunshot.wav")
//FMODSoundAddEffect(sound, 19,0);
//FMODSoundAddEffect(sound, 5,1);

//Action cannot be undone and you should not call this while an 
//instance of the sound exists

//Call before playing the sound


return external_call(global.dll_FMODSoundAddEffect,argument0,argument1,argument2);
