//export double FMODSoundLoop3d(double sound, double x, double y, double z, double paused)

//Plays (Loops) a sound relative to the player or listenner position

//returns 0 on error
//retuns a sound instance on success
//paused is optional. set to true and unpause later to play. 
//If you hear a short blurb of sound after you start the sound, 
//because you are playing with the instance settings
//you might want to start it paused.

//sound = FMODSoundAdd("gunshot.wav",true);
//FMODSoundSet3dMinMaxDistance(sound,100,300);
//FMODListenerSet3dPosition(1,50,50);
//instance = FMODSoundLoop3d(sound,300,300,0);

//You dont need to keep track of the instance if you dont plan to change it
//You can move the instance while it plays if you want
//See FMODSoundLoop for important details
//See FMODUpdate for important information
//See FMODSoundAdd for very important information
//See also FMODInstanceSetLoopCount()


var t;
t =  external_call(global.dll_FMODSoundLoop3d,argument0,argument1,argument2,argument3,argument4);
//FMODUpdate();
return t;
