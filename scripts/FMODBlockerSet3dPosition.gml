//export double FMODBlockerSet3dPosition(double blocker, double x, double y, double z)
//Blockers block sounds in the game, useful for walls, windows and other things

//Sets the position of a blocker in the room. Useful to slide doors
//binstance = FMODBlockerAdd(x,y,0,bbox_left,bbox_top,0,bbox_right,bbox_bottom,0);
//FMODBlockerSet3dPosition(binstance, x, y, 0)
return external_call(global.dll_FMODBlockerSet3dPosition, argument0, argument1, argument2, argument3);