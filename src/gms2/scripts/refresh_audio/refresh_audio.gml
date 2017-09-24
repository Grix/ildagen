//todo
FMODGMS_Sys_Update();

deltatime = FMODGMS_Chan_Get_Position(parse_sndchannel)*FMODGMS_Snd_Get_Length(song);

var t_repeatc = (floor(deltatime/1000*60 - (ds_list_size(audio_list))/3));
if ((t_repeatc) && !ds_list_empty(audio_list))
{
    var t_lastw = ds_list_find_value(audio_list,ds_list_size(audio_list)-3);
    var t_lastr = ds_list_find_value(audio_list,ds_list_size(audio_list)-2);
    var t_lastb = ds_list_find_value(audio_list,ds_list_size(audio_list)-1);
    repeat (t_repeatc)
    {
        ds_list_add(audio_list,t_lastw);
        ds_list_add(audio_list,t_lastr);
        ds_list_add(audio_list,t_lastb);
    }
}

if ((deltatime/1000*60 - ds_list_size(audio_list)/3) > 0)
{
	var t_w = FMODGMS_Chan_Get_Level(parse_sndchannel);
    ds_list_add(audio_list,ln(1+clamp(t_w*1.5,0,3.4)));
	
    /*FMODSpectrumSetSnapshotType(2);
    FMODInstanceGetSpectrumSnapshot2(parseinstance,0,t_numentries);
    s1 = FMODNormalizeSpectrumData(0,5);
    s3 = FMODNormalizeSpectrumData(40,150);
    FMODInstanceGetSpectrumSnapshot2(parseinstance,1,t_numentries);
    s2 = FMODNormalizeSpectrumData(0,5);
    s4 = FMODNormalizeSpectrumData(40,150);
    s = (s1+s2)/2;*/
	var t_s = 0;
    ds_list_add(audio_list,ln(1+clamp(t_s*8,0,3.4)));
    t_s = 0;
    ds_list_add(audio_list,ln(1+clamp(t_s*8,0,3.4)));
}
    
pos = FMODGMS_Chan_Get_Position(parse_sndchannel);
    
if (pos >= 0.998)
{
    parsingaudio = 0;
    deltatime = 0;
    FMODGMS_Chan_StopChannel(parse_sndchannel);
}
