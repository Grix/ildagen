//export double FMODGetWaveBuffer(double start, double size)
//returns 0 on error
//returns 1 on success 

//It's faster to use the string buffer method than getting every point using 
//FMODGetSnapshotEntry()


//var buf;
global.FMODbuf = string_repeat(chr(0), argument1+1);
//Gets the FMODGetWaveBuffer snapshot into a string buffer
//Each character is a value from 0to 255 to represent the wave played 
//the flatline is at char 127. 127-n is the -crest 127+n is the +crest of the wave form

//buffer = FMODGetWaveBuffer(0, 256)
//NOTE BECAUSE OF A GM BUG REGARDING LEAKS RETURNING STRINGS
//global.FMODbuf is now used
//Use ord(string_char_at(global.FMODbuf,<<1 to size>>)) to access values

return external_call(global.dll_FMODGetWaveBuffer,argument0,argument1,global.FMODbuf);
//return buf;
