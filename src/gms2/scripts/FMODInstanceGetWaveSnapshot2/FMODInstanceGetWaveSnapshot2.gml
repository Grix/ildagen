//export double FMODInstanceGetWaveSnapshot2(double instance, double channel, double size)
//This function stores data to a memory buffer which you can manipulate for better
//range using FMODNormalizeWaveData and read using 
//FMODGetWaveBuffer and FMODGetSnapshotEntry

//returns 0 on error
//Instance is the sound instance
//Channel is the sound channel (FMODSoundGetNumChannels to figure how many channels you need to fetch)
//It's usually good enough to get channel 0 (for mono sounds or left channel for stereo sounds) 1 is right, 2 and higher are the other channels if any
//size is the size of the buffer... keep it 2^n 32,64,128.... 16384(max)

//The bigger the sample size the more accurate the reading. Though FMOD documentation does not specify
//if the sample size corresponds to the smapshot window width or the precision of the snapshot.

//use FMODGetSnapshotEntry(pos) to get the data points 
//each point is a value from -1 to 1 representing the waveform crest point position

return external_call(global.dll_FMODInstanceGetWaveSnapshot2,argument0,argument1,argument2);
