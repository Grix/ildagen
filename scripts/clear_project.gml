tlpos = 0;    
playing = 0;
frame_surf_refresh = 1;

if (song)
    {
    FMODInstanceStop(songinstance);
    FMODSoundFree(song);
    }
    
ds_list_clear(layer_list);


