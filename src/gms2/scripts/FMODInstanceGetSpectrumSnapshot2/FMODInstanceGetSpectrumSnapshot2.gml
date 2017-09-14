//export double FMODInstanceGetSpectrumSnapshot2(double instance, double channel, double size)
//This function stores data to a memory buffer which you can manipulate for better
//range using FMODNormalizeSpectrumData and read using 
//FMODGetSpectrumBuffer and FMODGetSnapshotEntry

//returns 0 on error
//returns 1 on success
//Instance is the sound instance
//Channel is the sound channel (FMODSoundGetNumChannels to figure how many channels you need to fetch)
//It's usually good enough to get channel 0 (for mono sounds or left channel for stereo sounds) 1 is right, 2 and higher are the other channels if any
//size is the size of the buffer... keep it 2^n 64,128.... Min = 64. Max = 8192(max)

//Gets the spectrum snapshot into a string buffer
//If you need to average left and right channels create a more accurate display of both channels in one screen 
//you will need to call this twice (with 0 then with 1) then loop through each value, add them together and divide by 2
//The demo draws both left and right individually
//NOTE for drawing... If the sound is 41000 or 48000, consider asking for 256 bytes but display only the first 128
//like the demo does...That will draw frequencies 0 to 22KHz, the commun hearing frequencies

//The function does NOT normalize the values... 
//use FMODNormalizeSpectrumData() to do that

//use FMODGetSnapshotEntry(pos) to get the data points 
//each point is a value from 0 to 1 representing the spectrum value (volume at relative frequency)

return external_call(global.dll_FMODInstanceGetSpectrumSnapshot2,argument0,argument1,argument2);
