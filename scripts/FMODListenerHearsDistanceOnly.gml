//export double FMODListenerHearsDistanceOnly(double listener, double truefalse)

//Call this if you want to enable x,y,z relative 3d sounds
//listener is the id (1-4) of the listener
// true is default. 3d sounds will fade in and out but their relative position will not register in the speakers
// false, the 3d sounds will appear to eminated from the left when the sound is on the left, right if on the right giving a better idea where the sound is comming from
// this has no effect to the sounds stereo quality, only it's position
return external_call(global.dll_FMODListenerHearsDistanceOnly,argument0,argument1);