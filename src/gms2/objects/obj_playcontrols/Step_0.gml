if (instance_exists(oDropDown))
    exit;
    
if !((mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))) 
{
    image_index = 0;
    exit;
}

if (room = rm_ilda)
{
    switch (floor( (mouse_x-x)/20))
    {
        case 0: 
        {
            controller.tooltip = "Play. Shortcut: [Space bar]";
            image_index = 1;
            if (mouse_check_button_pressed(mb_left))
            {
                controller.playing = 1;
                if (seqcontrol.song)
                {
                    FMODInstanceSetPosition(seqcontrol.songinstance,(controller.tlx+controller.framehr)/seqcontrol.projectfps*1000/FMODSoundGetLength(seqcontrol.song));
                    FMODInstanceSetPaused(seqcontrol.songinstance,0);
                }
            }
            break;
        }
        case 1: 
        {
            image_index = 2;
            controller.tooltip = "Pause. Shortcut: [Space bar]";
            if (mouse_check_button_pressed(mb_left))
            {
                controller.playing = 0;
                FMODInstanceSetPaused(seqcontrol.songinstance,1);
            }
            break;
        }
        case 2: 
        {
            image_index = 3;
            controller.tooltip = "Stop and set position to start. Shortcut: [0]";
            if (mouse_check_button_pressed(mb_left))
            {
                ilda_cancel();
                controller.frame = 0;
                controller.framehr = 0;
            }
            break;
        }
    }
}
else
{
    switch (floor( (mouse_x-x)/20))
    {
        case 0: 
        {
            image_index = 1;
            controller.tooltip = "Play. Shortcut: [Space bar]";
            if (mouse_check_button_pressed(mb_left))
            {
                seqcontrol.playing = 1;
                if (seqcontrol.song)
                {
                    FMODInstanceSetPosition(seqcontrol.songinstance,(seqcontrol.tlpos+seqcontrol.audioshift)/FMODSoundGetLength(seqcontrol.song));
                    FMODInstanceSetPaused(seqcontrol.songinstance,0);
                }
            }
            break;
        }
        case 1: 
        {
            image_index = 2;
            controller.tooltip = "Pause. Shortcut: [Space bar]";
            if (mouse_check_button_pressed(mb_left))
            {
                seqcontrol.playing = 0;
                FMODInstanceSetPaused(seqcontrol.songinstance,1);
            }
            break;
        }
        case 2: 
        {
            image_index = 3;
            controller.tooltip = "Stop and set position to start. Shortcut: [0]";
            if (mouse_check_button_pressed(mb_left))
            {
                with (seqcontrol)
                {
                    tlx = 0;
                    playing = 0;
                    tlpos = 0;
                    if (song)
                    {
                        FMODInstanceStop(songinstance);
                        songinstance = FMODSoundPlay(song,1);
                        set_audio_speed();
                    }
                }
            }
            break;
        }
    }
}

