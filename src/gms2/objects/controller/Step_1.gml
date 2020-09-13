/// @description timing and laser output

if (room != rm_ilda) 
	exit;

if (playing == 1)
{
    if (maxframes <= 1)
    {
        playing = 0;
        if (seqcontrol.song != -1)
            FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
    }
        
    framehr += delta_time/1000000*seqcontrol.projectfps*seqcontrol.playbackspeed;
    if (framehr > maxframes-0.5)
        framehr -= maxframes;
    frame = clamp(round(framehr),0,maxframes-1);
    if (frame != frameprev)
    {
        frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
    }
        
    if (frameprev != 0) and (frame == 0) and (seqcontrol.song != -1)
    {
        fmod_set_pos(seqcontrol.play_sndchannel,clamp(tlx/seqcontrol.projectfps*1000, 0, seqcontrol.songlength));
    }
}

minroomspeed = 7.5;

if (laseron)
{
    if (!ds_list_exists(dac))
    {
        show_message_new("Error, DAC data missing");
        laseron = false;
        dac = -1;
    }
    else
        output_frame();
}
else 
    fpsmultiplier = 1;

room_speed = projectfps/fpsmultiplier;
while (room_speed < minroomspeed)
    room_speed += projectfps/fpsmultiplier;
game_set_speed(room_speed, gamespeed_fps);
