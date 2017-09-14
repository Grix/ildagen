//export double FMODSoundPlay3d(double sound, double x, double y, double z, double paused)

//Play a sound relative to the playe or listenner position

//returns 0 on error
//retuns a sound instance on success
//paused is optional. set to true and unpause later to play. 
//If you hear a short blurb of sound after you start the sound, 
//because you are playing with the instance settings
//you might want to start it paused.

//sound = FMODSoundAdd("gunshot.wav",true);
//FMODSoundSet3dMinMaxDistance(sound,100,300);
//FMODListenerSet3dPosition(1,50,50);
//instance = FMODSoundPlay3d(sound,300,300,0);

//You dont need to keep track of the instance if you dont plan to change it
//or if the sound is short, you may never have time to use it other that right
//after you make the PlaySoundCall... The instance will become invalid 
//when the sound is done playing. you can move the instance while it plays
//if you want
//See FMODUpdate for imprtant information
//See FMODSoundAdd for very important information
//var paused;
var t;
t =  external_call(global.dll_FMODSoundPlay3d,argument0,argument1,argument2,argument3,argument4);
//FMODUpdate();
return t;
