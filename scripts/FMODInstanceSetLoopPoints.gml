//export double FMODInstanceSetLoopPoints(double instance, double start, double end)

//returns 0 on error
//returns 1 on success

//Sets what part of the sound INSTANCE that will be looped
// sound is the sound that was added
// start (0 to 1) is the position of the start of the loop
// end (0 to 1) is the position of the end of the loop

//this set the loop point from 40% to 60% so only that part is looped
//only affects the instanciated sound, not the actual sound so other calls to sound loop will use the sound defaults
//instance = FMODSoundLoop(global.musicsound)
//FMODInstanceSetLoopPoints(instance,.4,.6);

return external_call(global.dll_FMODInstanceSetLoopPoints,argument0,argument1,argument2);
