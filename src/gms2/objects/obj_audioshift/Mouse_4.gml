if (instance_exists(obj_dropdown))
    exit;
with (seqcontrol)
{
    if (mouse_x > (obj_audioshift.x+23))
        audioshift += 10;
    else
        audioshift -= 10;
    
    if (song != -1)
        fmod_set_pos(play_sndchannel,clamp(((tlpos+audioshift)-10),0,songlength));
}

stringToDraw = "Offset: "+string_format(seqcontrol.audioshift,4,1)+"ms";

