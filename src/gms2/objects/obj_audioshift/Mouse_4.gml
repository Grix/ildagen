if (instance_exists(obj_dropdown))
    exit;
	
if (!visible)
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

stringToDraw = "Latency: "+string_format(seqcontrol.audioshift,3,1)+"ms";

