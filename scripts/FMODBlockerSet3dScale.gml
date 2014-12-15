//export double FMODBlockerSet3dScale(double blocker, double sx, double sy, double sz)
//Blockers block sounds in the game, useful for walls, windows and other things

//Sets the size of a blocker. You can match your image_x/yscale Just make sure you 
//added the blocker when the image_scale was 1 if you do.

//FMODBlockerSet3dScale(binstance, image_xscale, image_yscale, 0)
return external_call(global.dll_FMODBlockerSet3dScale, argument0, argument1, argument2, argument3);