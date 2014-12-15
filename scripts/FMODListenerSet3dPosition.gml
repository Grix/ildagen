//export double FMODListenerSet3dPosition(double number, double x, double y, double z)
//Sets the litenner position in the room
//number is the listenner id (1 to 4) to position
//See FMODUpdate for important information

//in player 1 end step
//FMODListenerSet3dPosition(1,x,y,0);

//in player 2 end step
//FMODListenerSet3dPosition(2,x,y,0);


return external_call(global.dll_FMODListenerSet3dPosition,argument0,argument1,argument2,argument3);