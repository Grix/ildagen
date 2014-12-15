//export double FMODListenerSet3dPositionEx(double number, double x, double y, double z, double fx, double fy, double fz, double ux, double uy, double uz)

//the extended version of FMODListenerSet3dPosition so you can do your 3d FPS setup

//Sets the litenner position in the room
//number is the listenner id (1 to 4) to position
//x,y,z are to world relative positions
//fx,fy,fz are the foreward directions in vectors 
//ux,uy,uz are the up direction in vertors 

//Dont ask me how it works, it depends on your game and how sound relates to the player
//It took me a while to tweak those values for top down and platform games
// (My IQ is that of a plant when it come to those)
//I assume you can use sin and cos degetorad(image_angle) in the right spots
//Internally, these values are 
//FMOD_VECTOR forward {x,y,z}       = { 0.0f, 0.0f, -1.0f };
//FMOD_VECTOR up {x,y,z}            = { 0.0f, -1.0f, 0.0f };
//For non stereoscopic 3d sound to player relationship (FMODListenerHearsDistanceOnly(1,true))
//FMOD_VECTOR up {x,y,z}            = { 0.0f, 0.0f, 0.0f };
//See FMODUpdate3dPositions for important information

//So, be aware that this may affect (override) the stereoscopic cancelation of 3d sounds
//set by MODSet3dDistanceOnly(true)

//This is the description from the FMOD documentation 'cause I cant explain it any better

//pos (x,y,z)
//Position of the listener in world space, measured in distance units. 

//forward (fx,fy,fz)
//The forwards orientation of the listener. This vector must be of unit length 
//and perpendicular to the up vector. 

//up (ux,uy,uz)
//The upwards orientation of the listener. This vector must be of unit length 
//and perpendicular to the forwards vector. 
 
//Remarks

//By default, FMOD uses a left-handed co-ordinate system. 
//This means +X is right, +Y is up, and +Z is forwards.

//To map to another coordinate system, flip/negate and exchange these values.

//Orientation vectors are expected to be of UNIT length. This means the magnitude of the vector should be 1.0.

//Yeah... very useful... thanks... As you can see, for these guys, 3d is so second nature that their
//explaination is useless unless you already know how it works. It basically fails to explain how to 
//set the vectors. And I can't help you with those either.


//in player 1 end step
//FMODListenerSet3dPositionEx(1, x,y,0, 0,0,-1, 0,-1,0);

//in player 2 end step
//FMODListenerSet3dPositionEx(2, x,y,0, 0,0,-1, 0,-1,0);


return external_call(global.dll_FMODListenerSet3dPositionEx,argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9);