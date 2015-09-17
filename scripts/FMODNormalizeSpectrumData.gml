//export double FMODNormalizeSpectrumData(double startpos, double size)
//Normalizes the spectrum data from start to start+size to increase the data range values
//which is useful for better display of the data
//The effect is that values that are very small will stretch according to the
//highest value of the set. For eaxmple, if the highest value was .05 and the others
//.005, .0005, the highest will be bumped to 1 making the others .1 and .01
//For display purpose, it ensures you always have data to see.

//Returns the calculated value use in the normalization (max value in the dtata set)
//v = FMODInstanceGetSpectrumSnapshot2(instance,0, 1024);
//FMODNormalizeSpectrumData(0, 1024);
//for(i=0; i<1024,i+=1)
//{
//    entry = FMODGetSnapshotEntry(i);
//}

return external_call(global.dll_FMODNormalizeSpectrumData,argument0,argument1);
