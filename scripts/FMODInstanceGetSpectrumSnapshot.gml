//export double FMODInstanceGetSpectrumSnapshot(double instance, double channel, double size)
//returns 0 on error
//returns maxv on success (so, the return of 0 could be an error or maxv)

//Instance is the sound instance
//Channel is the sound channel (FMODSoundGetNumChannels to figure how many channels you need to fetch)
//It's usually good enough to get channel 0 (for mono sounds or left channel for stereo sounds) 1 is right, 2 and higher are the other channels if any
//size is the size of the buffer... keep it 2^n 64,128.... Min = 64. Max = 8192(max)

//var buf;
global.FMODbuf = string_repeat(chr(0), argument2+1);
//Gets the spectrum snapshot into a string buffer
//Each character is a value from 0to 255 to represent the spectrum played 
//unuseable = FMODInstanceGetSpectrumSnapshot(instance,0, 256)

//NOTE BECAUSE OF A GM BUG REGARDING LEAKS RETURNING STRINGS
//global.FMODbuf is now used

//Use ord(string_char_at(global.FMODbuf,<<1 to size>>)) to access values
//If you need to average left and right channels create a more accurate display of both channels in one screen 
//you will need to call this twice (with 0 then with 1) then loop through each value, add them together and divide by 2
//The demo draws both left and right individually
//NOTE for drawing... If the sound is 41000 or 48000, consider asking for 256 bytes but display only the first 128
//like the demo does...That will draw frequencies 0 to 22KHz, the commun hearing frequencies

//The function normalises the values... That is the highest value will always be 255... 
//This ensures your will get the maximum range possible. Done in the Dll this is faster 
//than GM would do it with strings. Since I figure most poeple will want this on default...
//However, the retun call of the DLL function returns the max value and I stuff it in a member
//variable FMODMaxV so you may un-normalize the data if you need to using
//ord(string_char_at(buffer,<<1 to size>>))*FMODMaxV
FMODMaxV = external_call(global.dll_FMODInstanceGetSpectrumSnapshot,argument0,argument1,argument2,global.FMODbuf);
return FMODMaxV;
