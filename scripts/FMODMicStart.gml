//export double FMODMicStart(double sound)
//Starts recording on a sound...
//Returns an instance of the sound recorded my the mic

//    sound = FMODCreateSoundFromMicInput();
//    if (!sound) exit;
//    instance = FMODMicStart(sound);
//    FMODInstanceSetVolume(instance,0); //mute to prevent feedback

// when done
//    FMODInstanceStop(instance);
//    FMODRecordStop();
//    FMODSoundFree(sound)
//    sound = 0;
//    instance = 0;

return external_call(global.dll_FMODRecordStart, argument0);
