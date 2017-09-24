if (instance_exists(obj_dropdown))
    exit;
if (os_browser != browser_not_a_browser)
{
    show_message_new("Laser output not supported in the web version");
    exit;
}
   
if (room = rm_ilda)
{ 
    with (controller)
    {
        ds_list_clear(semaster_list);
        
        if (laseron)
        {
            laseron = false;
            frame_surf_refresh = true;
            dac_blank_and_center(dac);
        }
        else if (ds_exists(dac, ds_type_list))
        {
            laseron = true;
            laseronfirst = true;
        }
        else
        {
            show_message_new("No DACs found. Please go to settings and set up the connection (Click SCAN).");
            ilda_cancel();
            room_goto(rm_options);
        }
    }
}
else if (room = rm_seq)
{ 
    if (!verify_serial(true))
        exit;
        
    with (controller)
    {
        if (laseron)
        {
            laseron = false;
            seqcontrol.frame_surf_refresh = true;
            close_dacs();
        }
        else if (ds_exists(dac, ds_type_list))
        {
            laseron = true;
            laseronfirst = true;
            seqcontrol.frame_surf_refresh = true;
        }
        else
        {
            show_message_new("No DACs found. Please go to settings and set up the connection (Click SCAN).");
            if (seqcontrol.song != 0) 
                FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
            seqcontrol.playing = 0;
            room_goto(rm_options);
        }
    }
}
if (room = rm_options)
{ 
    with (controller)
    {
        if (preview_testframe != 2)
        {
            if (laseron)
            {
                laseron = false;
                frame_surf_refresh = true;
                dac_blank_and_center(dac);
            }
            else if (ds_exists(dac, ds_type_list))
            {
                laseron = true;
                laseronfirst = true;
            }
            else
            {
                show_message_new("No DACs found. Please set up the connection (Click SCAN).");
            }
        }
        else
        {
            if (laseron)
            {
                laseron = false;
                seqcontrol.frame_surf_refresh = true;
                close_dacs();
            }
            else if (ds_exists(dac, ds_type_list))
            {
                laseron = true;
                laseronfirst = true;
                seqcontrol.frame_surf_refresh = true;
            }
            else
            {
                show_message_new("No DACs found. Please set up the connection (Click SCAN).");
            }
        }
    }
}

