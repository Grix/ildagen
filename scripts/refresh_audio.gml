var numentries = 1024;
    
FMODUpdate();

if (errorcheck == 0) and (deltatime > 1000000/60*10)
    {
    errorcheck = 1;
    }
deltatimeprev = deltatime;
deltatime += delta_time;

    
if (errorcheck)
    {
    lastw = ds_list_find_value(audio_list,ds_list_size(audio_list)-3);
    lastr = ds_list_find_value(audio_list,ds_list_size(audio_list)-2);
    lastb = ds_list_find_value(audio_list,ds_list_size(audio_list)-1);
    repeat (floor(deltatime/1000000*60) - round(deltatimeprev/1000000*60)-1)
        {
        ds_list_add(audio_list,lastw);
        ds_list_add(audio_list,lastr);
        ds_list_add(audio_list,lastb);
        }
    }
//show_debug_message(ds_list_size(audio_list))
//show_debug_message(errorcheck)
    
    

FMODInstanceGetWaveSnapshot2(parseinstance,0,numentries);
w = FMODNormalizeWaveData(0,numentries);
ds_list_add(audio_list,ln(1+clamp(w*1.5,0,3.4)));
FMODSpectrumSetSnapshotType(1);
FMODInstanceGetSpectrumSnapshot2(parseinstance,0,numentries);
s = FMODNormalizeSpectrumData(0,5);
ds_list_add(audio_list,ln(1+clamp(s*8,0,3.4)));
//show_debug_message(s)
s = FMODNormalizeSpectrumData(50,250);
ds_list_add(audio_list,ln(1+clamp(s*10,0,3.4)));
//show_debug_message(s)

pos = FMODInstanceGetPosition(parseinstance);

//if (pos/1000*projectfps == clamp(pos/1000*projectfps,tlx,tlx+tlzoom))
    refresh_audio_surf();
    
if (pos >= 0.999)
    {
    parsingaudio = 0;
    deltatime = 0;
    }
