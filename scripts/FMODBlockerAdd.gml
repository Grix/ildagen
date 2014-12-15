//export double FMODBlockerAdd(double x, double y, double z, double xs, double ys, double zs, double xe, double ye, double ze)
//Blockers block sounds in the game, useful for walls, windows and other things

//Adds a blocker to the system
//Returns the blockerID to use with any move functions... Usedful for moving doors or fading blockers
//x,y,z are the position of your object
//xs,ys,zs are the start position of the cube
//xe,ye,ze are the end position of the cube
//Blockers are destroyed when you call FMODBlockersFree()
//On default, the blocker will be full on. You can reduce this using the blocker instance
//FMODBlockersInit(instance_number(wallsobj) + instance_number(doorsobj),room_width,room_height,0);
//binstance = FMODBlockerAdd(x,y,0,bbox_left,bbox_top,0,bbox_right,bbox_bottom,0);
//see also FMODBlockersAddGMObjects()
return external_call(global.dll_FMODBlockerAdd, argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8);