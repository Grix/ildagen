var numentries = 1024;
    
FMODUpdate();

FMODInstanceGetWaveSnapshot2(parseinstance,0,numentries);
w = FMODNormalizeWaveData(0,numentries)
ds_list_add(audio_list,w);
      
FMODSpectrumSetSnapshotType(1);
FMODInstanceGetSpectrumSnapshot2(parseinstance,0,numentries);
s = FMODNormalizeSpectrumData(0,5);
ds_list_add(audio_list,ln(1+clamp(s*8,0,45*1.7)));
//show_debug_message(s)
s = FMODNormalizeSpectrumData(50,200);
ds_list_add(audio_list,ln(1+clamp(s*10,0,45*1.7)));
//show_debug_message(s)

pos = FMODInstanceGetPosition(parseinstance);

//if (pos/1000*projectfps == clamp(pos/1000*projectfps,tlx,tlx+tlzoom))
    refresh_audio_surf();
    
if (pos >= 1)
    parsingaudio = 0;