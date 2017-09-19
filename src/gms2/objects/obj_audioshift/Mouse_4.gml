if (instance_exists(oDropDown))
    exit;
with (seqcontrol)
{
    if (mouse_x > (obj_audioshift.x+23))
        audioshift += 10;
    else
        audioshift -= 10;
    
    if (song != 0)
        FMODGMS_Chan_Set_Position(play_sndchannel,(tlpos+audioshift)/FMODGMS_Snd_Get_Length(song));
}

stringToDraw = "Offset: "+string_format(seqcontrol.audioshift,4,1)+"ms";

