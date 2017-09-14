//export double FMODEffectGetSpeakerActive(double effect, double speaker)
//This function gets the if the effect is active on the speaker

//true/false = FMODEffectGetSpeakerActive(effect,speaker 0 to number of speakers);

//returns if the effect is active on the speaker


//Have not tried this


return external_call(global.dll_FMODEffectGetSpeakerActive,argument0, argument1);
