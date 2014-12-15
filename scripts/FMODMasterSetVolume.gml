//export double FMODMasterSetVolume(double volume)

//This sets the global volume. changes are relative to the sounds max volume and 
//the group they belong too

//You need to keep track of the volume yourself in a variable 
//if you need to remember the global volume
// overall = maxvalue*instancevalue*group*global*distancefactor

return external_call(global.dll_FMODMasterSetVolume,argument0);