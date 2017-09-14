//export double FMODNormalizeWaveData(double startpos, double size)
//Normalizes the wave data from start to start+size to increase the data range values
//which is useful for better display of the data though the accuracy of the wave form
//will be affected... Not that it matters in this case.
//Portions of the wave that have very little deltav will show an exagerated deltav so
//you can see the wave instead of a straight line.
//A side effect is that larger variations may be reduced... but overall, the effect is 
//acceptable for use in draw function

//Returns the calculated value use in the normalization (max range variation value in the data set)
//FMODInstanceGetWaveSnapshot2(instance,0, 1024);
//FMODNormalizeWaveData(0, 1024);
//for(i=0; i<1024,i+=1)
//{
//    entry = FMODGetSnapshotEntry(i);
//}

return external_call(global.dll_FMODNormalizeWaveData,argument0, argument1);
