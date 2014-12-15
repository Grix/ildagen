//export double FMODBlockerGetEnabled(double blocker)
//Blockers block sounds in the game, useful for walls, windows and other things

//Returns true if a blocker is ON, false if not.

//Example to toggle on off
//FMODBlockerSetEnabled(binstance,!FMODBlockerGetEnabled(binstance))
return external_call(global.dll_FMODBlockerGetEnabled, argument0);