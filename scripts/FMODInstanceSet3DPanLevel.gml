//export double FMODInstanceSet3DPanLevel(double instance, double panlevel)
//returns 1 on succes, 0 on error

//A 3d sound instance pan level can be changed from 0 up to 1
//Where 1 (default) means the 3d sound instance is perceived as per the 
//listener's position.
//0 mean the sound plays on all speakers as it would play normally
//Gradually changing the value from 1 to 0 would give the player the impression 
//the sound started at a 3d location and is now all arround him

//Of course, FMODListenerHearsDistanceOnly affects the way this behaves
return external_call(global.dll_FMODInstanceSet3DPanLevel,argument0,argument1);
