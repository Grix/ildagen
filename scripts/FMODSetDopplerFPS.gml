//export double FMODSetDopplerFPS(double fps)

//Sets the sound system's framespersecond value to use in doppler effect calculations
//fps is the frame per second of your game. (room_speed or fps)
//set to 0 (default) to disable the doppler effect

//You may play with this value to achive the right doppler effect for your game
//though using wolrd scale is recommended
return external_call(global.dll_FMODSetDopplerFPS,argument0);