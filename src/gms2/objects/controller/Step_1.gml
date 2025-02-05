/// @description timing and laser output

if (room != rm_ilda) 
	exit;
	
if (livecontrol.loadprojectflag)
	room_goto(rm_live);
else if (seqcontrol.loadprojectflag)
	room_goto(rm_seq);

if (playing == 1)
{
    if (maxframes <= 1)
    {
        playing = 0;
        if (seqcontrol.song != -1)
            FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
    }
        
	var t_deltaframe = delta_time/1000000*seqcontrol.projectfps*seqcontrol.playbackspeed;
	if (!laseron || (fps_real-10 < fps) || t_deltaframe >= 1.99*controller.fpsmultiplier)
		framehr += t_deltaframe;
	else
	{
		if (debug_mode)
		{
			if (t_deltaframe > 1.02*controller.fpsmultiplier || t_deltaframe < 0.98*controller.fpsmultiplier)
				log("CORRECTED frame from", t_deltaframe);
		}
		framehr += 1*controller.fpsmultiplier;
	}
		
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


if (laseron)
{
    if (!ds_list_exists_pool(dac))
    {
        show_message_new("Error, DAC data missing");
        laseron = false;
        dac = -1;
    }
    else
        output_frame();
		
	test_numsteps++;
	test_time += delta_time;
		
	minroomspeed = 7.5;
	_room_speed = projectfps/fpsmultiplier;
	while (_room_speed < minroomspeed)
	    _room_speed += projectfps/fpsmultiplier;
}
else
	_room_speed = 60; //clamp(display_get_frequency(), 60, 144);

if (game_get_speed(gamespeed_fps) != _room_speed)
	game_set_speed(_room_speed, gamespeed_fps);
