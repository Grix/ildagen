//export double FMODSoundSet3dCone(double sound, double insideconeangle, double outsideconeangle, double outsidevolume)

//Call before you play the sound
//Should work the same as GM sound_3d_set_sound_cone
//But you set the position using the instance FMODInstanceSet3dPosition
//and you set it's relative direction using FMODInstanceSet3dConeOrientation

//I have not tested this feature

return external_call(global.dll_FMODSoundSet3dCone,argument0,argument1,argument2,argument3);
