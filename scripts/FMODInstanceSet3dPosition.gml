//export double FMODInstanceSet3dPosition(double instance,double x,double y,double z)
//Chages the position of a sound instance

//returns 0 on error
//returns 1 on success

//Sound must be 3d
//sound = FMODSoundAdd("gunshot.wav",true);
//FMODSoundSet3dMinMaxDistance(sound,100,300);
//FMODListenerSet3dPosition(1,50,50);
//instance = FMODSoundLoop3d(sound,300,300,0);

//later (end step)
//FMODInstanceSet3dPosition(instance,x,y,0);

//FMODUpdate for important information
return external_call(global.dll_FMODInstanceSet3dPosition,argument0,argument1,argument2,argument3);
