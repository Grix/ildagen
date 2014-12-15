//export double FMODInstanceSet3dDopplerMax(double sound, double dopplerval)
//Call this to set the instance doppler setting

//FMODSetDopplerFPS(room_speed) must have been called for doppler to work 
return external_call(global.dll_FMODInstanceSet3dDopplerMax,argument0,argument1);