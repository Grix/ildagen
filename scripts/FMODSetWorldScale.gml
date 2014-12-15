//export double FMODSetWorldScale(double scale)
//Sets the scale of the worls.
//Default scale is 1 meter per pixel
//it affects the doppler effect
//if your player moves 3 pixels in one second
//it will appear to the sound system as though he moved
//3 meters per second 
//reduce the value to reduce the overall doppler effects in the game

return external_call(global.dll_FMODSetWorldScale,argument0);