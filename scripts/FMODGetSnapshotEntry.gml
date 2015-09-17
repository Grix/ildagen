//export double FMODGetSnapshotEntry(double pos)
//returns the data point value at position pos

//FMODInstanceGetWaveSnapshot2(instance,0, 1024);
//FMODNormalizeWaveData(1024);
//for(i=0; i<1024,i+=1)
//{
//    entry = FMODGetSnapshotEntry(i);
//}

return external_call(global.dll_FMODGetSnapshotEntry,argument0);
