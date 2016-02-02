with (seqcontrol)
    {
    if (song) FMODInstanceSetPaused(songinstance,1);
    playing = 0;
    room_goto(rm_ilda);
    }
