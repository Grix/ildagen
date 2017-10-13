with (seqcontrol)
{
    if (song != -1) 
        FMODGMS_Chan_PauseChannel(play_sndchannel);
    playing = 0;
    room_goto(rm_ilda);
}
