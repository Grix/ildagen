//export double FMODInstanceSet3dConeOrientation(double instance, double dx, double dy, double dz)

//Should work like GM's sound_3d_set_sound_cone, the actual cone definition is done with the sound
//using FMODSoundSet3dMinMaxDistance()

//dx,dy,dz are the directional vectors... Again, dont ask me how the relate... See FMODListenerSet3dPositionEx()

//the instance must be of a 3d sound 

//I have not tested this feature

return external_call(global.dll_FMODInstanceSet3dConeOrientation,argument0,argument1,argument2,argument3);
