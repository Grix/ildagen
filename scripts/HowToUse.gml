
var t;
t = "

Go here for details
Forum: http://gmc.yoyogames.com/index.php?showtopic=333705
GMFMODSimple v4.28 
Using 
FMOD Sound System, copyright � Firelight Technologies Pty, Ltd., 1994-2007.
FMOD Ex API version: 4.28 
"


///////////////////////////////////////////////////////////
//Copy these code snippets to the right spots in your game

//////////////////////
//Simple setup
//On Game Start
LoadFMOD();
FMODinit(100,0);
//using a password
//FMODSetPassword("password");


//To load sounds
//game background music
global.bkMusic = FMODSoundAdd("bkmusic.mid",0,0);
FMODSoundSetGroup(global.bkMusic,3);
//To set the volume to 80%
FMODSoundSetMaxVolume(global.bkMusic,.8);

//To load a special effect
global.gunshot = FMODSoundAdd("gunshot.wav",0,0);
FMODSoundSetGroup(global.gunshot,2);

//On Room Start
FMODSoundLoop(global.bkMusic,0);

//On Sound Controller end Step
FMODUpdate();

//On Player Fire Gun
FMODSoundPlay(global.gunshot,0);

//On room end
FMODAllStop();

//On Game End
//to free the sounds
FMODSoundFree(global.bkMusic);
FMODSoundFree(global.gunshot);
//to free the system
FMODfree();
UnloadFMOD();
//Simple setup end
////////////////////////


//////////////////////
//3d setup
//On game start
LoadFMOD();
FMODinit(100,0);
//using a password
//FMODSetPassword("password");


//To load sounds
//game background music
global.bkMusic = FMODSoundAdd("bkmusic.mid",0,0);
FMODSoundSetGroup(global.bkMusic,3);
//To set the volume to 80%
FMODSoundSetMaxVolume(global.bkMusic,.8);

//To load a special effect
global.gunshot = FMODSoundAdd("gunshot.wav",true,0);
FMODSoundSetGroup(global.gunshot,2);
//to set it's 3d settings
FMODSoundSet3dMinMaxDistance(global.gunshot, 200,600);

//To load a ambient effect
global.enemygrunt = FMODSoundAdd("enemygrunting.wav",true,0);
FMODSoundSetGroup(global.enemygrunt,4);
//to set it's 3d settings
FMODSoundSet3dMinMaxDistance(global.enemygrunt,100,400);


//On Room Start
FMODSoundLoop(global.bkMusic,0);

//On Player Fire Gun
FMODSoundPlay3d(global.gunshot,x,y,0,0);
//On Player end step
FMODListenerSet3dPosition(1,x,y,0);

//On Sound Controller end Step
FMODUpdate();

//On enemy create
instance = FMODSoundLoop3d(global.enemygrunt,x,y,0,0);
//on enemy end step
FMODInstanceSet3dPosition(instance,x,y,0)
//On Enemy Fire Gun
FMODSoundPlay3d(global.gunshot,x,y,0,0);


//On room end
FMODAllStop();

//On Game End
//to free the sounds
FMODSoundFree(global.bkMusic);
FMODSoundFree(global.enemygrunt);
FMODSoundFree(global.gunshot);
//to free the system
FMODfree();
UnloadFMOD();
//3d setup end
////////////////////////

//////////////////////////////
//To quickly play a file in an object without having it loaded on game start
//on create
sound = 0;
instance = 0;
alarm[0] = 1;

//on alarm[0]
sound = FMODSoundAdd("music.mid",0,0);
FMODSoundSetGroup(sound,3);
instance = FMODSoundLoop(sound,0);


//on room end
instance_destroy();

//on instance destroy
FMODInstanceStop(instance);
FMODSoundFree(sound);
//////////////////////////////
//////////////////////////////

//////////////////////////////
//To quickly play random files in an object without having it loaded on game start
//on create
sound = 0;
instance = 0;
alarm[0] = 1;

//on alarm[0]
if(!FMODInstanceIsPlaying(instance)) //The system is smart enough to handle 0
{
    FMODInstanceStop(instance);
    FMODSoundFree(sound);
    sound = FMODSoundAdd(choose("music1.mid","music2.mid","music3.mid","music4.mid"),0,0);
    FMODSoundSetGroup(sound,3);
    instance = FMODSoundPlay(sound,0);
}

alarm[0] = room_speed;

//on room end
instance_destroy();

//on instance destroy
FMODInstanceStop(instance);
FMODSoundFree(sound);
//////////////////////////////
//////////////////////////////


//////////////////////////////
//To quickly play a file in a moving object without having it loaded on game start
//Recommended for MIDIs or streamed files
/*
//on create
sound = 0;
instance = 0;
alarm[0] = 1;
path_start(path0,3,3,true);
*/
//on alarm[0]
//sound = FMODSoundAdd("music.mid",true,false /* or true if large mp3*/);
//It's really like a moving boombox or a talking character, so ambient effect group could be used
/*
FMODSoundSetGroup(sound,4);
FMODSoundSet3dMinMaxDistance(sound,100,300);
instance = FMODSoundLoop3d(sound,x,y,0,0);

//on end step
FMODInstanceSet3dPosition(instance,x,y,0);
//With the player or controler object
//calling FMODUpdate3dPositions(); 
//once every step, this should work fine


//on room end
instance_destroy();

//on instance destroy
FMODInstanceStop(instance);
FMODSoundFree(sound);
//////////////////////////////
//////////////////////////////


/////////////////////////
/////////////////////////
//Example web music

//On Game Start
LoadFMOD();
FMODinit(100,true);

//To load sounds
//game background music
global.bkMusic = FMODSoundAdd("http://thewebsite/thewebfileofmusicprovider",false,true);
FMODSoundSetGroup(global.bkMusic,3);
//To set the volume to 80%
FMODSoundSetMaxVolume(global.bkMusic,.8);

//On Player Fire Gun
FMODSoundPlay(global.bkMusic,0);

//On room end
FMODAllStop();

//On Game End
//to free the sounds
FMODSoundFree(global.bkMusic);
//to free the system
FMODfree();
UnloadFMOD();
//web setup end
////////////////////////


//////////
//Example instance saving code script
//Play3dEcono
//Must be called by object making the noise
//You mus set the playerobject to your object
with(PlayerObj)
{
    if(point_distance(x,y,other.x,other.x) < FMODSoundGetMaxDist(argument0))
    {
        FMODSoundPlay3d(argument0,other.x,other.y,0,0);
    }
}
///////////////////
/////////////////
*/