//export double FMODGroupSetFrequency(double group, double freq)

//Set the group frequency. 44100 is usually the defaul frequency
//Regular Groups are 1-4. 0 for the master group. Useful for bullet time on all sounds
//Carefull, this overrides the instance frequency too and you may not be able to reset it to normal
//See Also FMODGroupSetPitch
return external_call(global.dll_FMODGroupSetFrequency,argument0,argument1);