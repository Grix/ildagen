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
		
	minroomspeed = 7.5;
	_room_speed = projectfps/fpsmultiplier;
	while (_room_speed < minroomspeed)
	    _room_speed += projectfps/fpsmultiplier;
}
else
	_room_speed = 60; //clamp(display_get_frequency(), 60, 144);

game_set_speed(_room_speed, gamespeed_fps);
