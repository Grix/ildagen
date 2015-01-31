    FMODInstanceSetPitch(songinstance,playbackspeed);

    for (i = 0; i < ds_list_size(effect_list); i++)
        {
        FMODEffectFree(ds_list_find_value(effect_list,i));
        }
    ds_list_clear(effect_list);
    
    if (playbackspeed > 1)
        {
        repeat (floor(playbackspeed))
            {
            pitchshift = FMODInstanceAddEffect(songinstance, 11);
            FMODEffectSetParamValue(pitchshift, 0, 1/1.5);
            FMODEffectSetParamValue(pitchshift, 1, 4096*2);
            ds_list_add(effect_list,pitchshift);
            }
        }
    else if (playbackspeed < 1)
        {
        show_debug_message(4-floor(playbackspeed*5))
        repeat (4-floor(playbackspeed*5))
            {
            pitchshift = FMODInstanceAddEffect(songinstance, 11);
            FMODEffectSetParamValue(pitchshift, 0, 1.5);
            FMODEffectSetParamValue(pitchshift, 1, 4096*2);
            ds_list_add(effect_list,pitchshift);
            
            }
        }
