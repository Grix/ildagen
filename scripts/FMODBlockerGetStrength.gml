//export double FMODBlockerGetStrength(double blocker)
//Blockers block sounds in the game, useful for walls, windows and other things

//Returns the strength of a blocker. 0-no blocking, .5 half blocking 1 full blocking
//Example fading
//FMODBlockerSetStrength(binstance,FMODBlockerGetStrength(binstance)-.01);
return external_call(global.dll_FMODBlockerGetStrength, argument0);