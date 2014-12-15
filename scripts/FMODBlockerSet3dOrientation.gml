//export double FMODBlockerSet3dOrientation(double blocker, double fx, double fy, double fz, double ux, double uy, double uz)
//Blockers block sounds in the game, useful for walls, windows and other things

//Sets the orientation of a blocker in the room. Useful to rotate doors
//binstance = FMODBlockerAdd(x,y,0,bbox_left,bbox_top,0,bbox_right,bbox_bottom,0);
//fx,fy,fz are the facing direction vectors
//ux,uy,uz are the upward direction vectors
//Dont ask me to explain vectors... See ListenerSet3dPositionEx
//the default vectors are set for a 2d game and are
//TODO Defaults here
//FMODBlockerSet3dOrientation(binstance, 1,0,1,0,1,0)
return external_call(global.dll_FMODBlockerSet3dOrientation, argument0, argument1, argument2, argument3, argument4, argument5, argument6);