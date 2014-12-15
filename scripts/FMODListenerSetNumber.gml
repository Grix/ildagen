//export double FMODListenerSetNumber(double number)

//Use this to set the number of listener in the game room
//A listenner is usally a player... Player 2 can be another listener
// A listener can also be a "game microphone" in the room, hearing 
// the sounds in the room and playing them on the speaker.

//You can have up to 4 listeners in the room
//When there are more than 1 listener, the doppler effects are disabled
return external_call(global.dll_FMODListenerSetNumber,argument0);