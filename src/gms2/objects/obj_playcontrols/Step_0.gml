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
                if (seqcontrol.song != 0)
                {
                    FMODGMS_Chan_Set_Position(seqcontrol.play_sndchannel,(controller.tlx+controller.framehr)/seqcontrol.projectfps*1000/FMODGMS_Snd_Get_Length(seqcontrol.song));
                    FMODGMS_Chan_ResumeChannel(seqcontrol.play_sndchannel);
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
				if (seqcontrol.song != 0)
					FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
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
                if (seqcontrol.song != 0)
                {
                    FMODGMS_Chan_Set_Position(seqcontrol.play_sndchannel,(seqcontrol.tlpos+seqcontrol.audioshift)/FMODGMS_Snd_Get_Length(seqcontrol.song));
                    FMODGMS_Chan_ResumeChannel(seqcontrol.play_sndchannel);
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
				if (seqcontrol.song != 0)
					FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
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
                    if (song != 0)
                    {
                        FMODGMS_Chan_StopChannel(play_sndchannel);
                        FMODGMS_Snd_PlaySound(song, play_sndchannel);
                        set_audio_speed();
                    }
                }
            }
            break;
        }
    }
}

