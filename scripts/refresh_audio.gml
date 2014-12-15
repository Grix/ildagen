var numentries = 1024;
    
FMODUpdate();

FMODInstanceGetWaveSnapshot2(parseinstance,0,numentries);
w = FMODNormalizeWaveData(0,numentries)
//w = FMODGetSnapshotEntry(500)
ds_list_add(audio_list,w);
      
FMODSpectrumSetSnapshotType(1);
//FMODInstanceGetSpectrumSnapshot2(songinstance,0,numentries);
FMODInstanceGetSpectrumSnapshot2(parseinstance,0,numentries);
s = FMODNormalizeSpectrumData(0,5);
//s = FMODGetSnapshotEntry(8)
ds_list_add(audio_list,clamp(s*5,0,45));
s = FMODNormalizeSpectrumData(100,400);
//s = FMODGetSnapshotEntry(8)
ds_list_add(audio_list,clamp(s*5,0,45));


pos = FMODInstanceGetPosition(parseinstance);

if (pos/1000*projectfps = clamp(pos/1000*projectfps,tlx,tlx+tlw))
    refresh_audio_surf();
