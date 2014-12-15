//export double FMODBlockerSetEnabled(double blocker, double enabled)
//Blockers block sounds in the game, useful for walls, windows and other things

//Turns a blocker ON OFF. Useful is a wall is destroyed

//FMODBlockerSetEnabled(binstance, false)
return external_call(global.dll_FMODBlockerSetEnabled, argument0, argument1);