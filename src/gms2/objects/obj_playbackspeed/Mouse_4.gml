if (instance_exists(oDropDown))
    exit;
with (seqcontrol)
    {
    if (mouse_x > (obj_playbackspeed.x+23))
        playbackspeed *= 1.5;
    else
        playbackspeed /= 1.5;
    if (playbackspeed < 0.19)
        playbackspeed = 1/power((1.5),4);
    if (playbackspeed > 3.376)
        playbackspeed = 3.375;
    
    set_audio_speed();
    }
    
stringToDraw = "Speed: "+string(round(seqcontrol.playbackspeed*100))+"%";


