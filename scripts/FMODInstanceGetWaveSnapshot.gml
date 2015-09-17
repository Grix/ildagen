//export double FMODInstanceGetWaveSnapshot(double instance, double channel, double size)
//returns 0 on error
//returns 1 success
//Instance is the sound instance
//Channel is the sound channel (FMODSoundGetNumChannels to figure how many channels you need to fetch)
//It's usually good enough to get channel 0 (for mono sounds or left channel for stereo sounds) 1 is right, 2 and higher are the other channels if any
//size is the size of the buffer... keep it 2^n 32,64,128.... 16384(max)

//var buf;
global.FMODbuf = string_repeat(chr(0), argument2+1);
//Gets the wave snapshot into a string buffer
//Each character is a value from 0to 255 to represent the wave played (not the full wave, just the portion being played)
//success = FMODInstanceGetWaveSnapshot(instance,0, 256)
//The bigger the sample size the more accurate the reading. Though FMOD documentation does not specify
//if the sample size corresponds to the smapshot window width or the precision of the snapshot.

//the flatline is at char 127. 127-n is the -crest 127+n is the +crest of the wave form

//NOTE BECAUSE OF A GM BUG REGARDING LEAKS RETURNING STRINGS
//global.FMODbuf is now used
//Use ord(string_char_at(global.FMODbuf,<<1 to size>>)) to access values
//If you need to average left and right channels create a more accurate display of both channels in one screen 
//you will need to call this twice (with 0 then with 1) then loop through each value, add them together and divide by 2
//The demo draws both left and right individually

return external_call(global.dll_FMODInstanceGetWaveSnapshot,argument0,argument1,argument2,global.FMODbuf);
//return buf;
