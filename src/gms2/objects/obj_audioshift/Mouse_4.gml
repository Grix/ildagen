if (instance_exists(oDropDown))
    exit;
with (seqcontrol)
    {
    if (mouse_x > (obj_audioshift.x+23))
        audioshift += 10;
    else
        audioshift -= 10;
    
    if (song)
        FMODInstanceSetPosition(songinstance,(tlpos+audioshift)/FMODSoundGetLength(song));
    }

stringToDraw = "Offset: "+string_format(seqcontrol.audioshift,4,1)+"ms";

