/// @description timing and laser output
if (room != rm_seq) exit;

//var timerbm = get_timer();

if (playing == 1)
{
    var t_tlpos_prev = tlpos;
    tlpos += delta_time/1000*playbackspeed;
    
	if ((t_tlpos_prev <= endframe/projectfps*1000) && (tlpos > endframe/projectfps*1000))
	{
		//if crossed the end marker
	    
		if (!ds_list_empty(playlist_list))
		{
			playlist_start_next_flag = true;
			load_project(playlist_list[| 0]);
			exit;
		}
		else if (loop)
	    {
	        tlpos = startframe/projectfps*1000;
		}
	}
    
    if (song != -1) && (t_tlpos_prev <= length/projectfps*1000) && (tlpos > length/projectfps*1000)
    {
		//playing = 0;
        //tlpos = 0;
        FMODGMS_Chan_StopChannel(play_sndchannel);
		FMODGMS_Snd_PlaySound(song, play_sndchannel);
        apply_audio_settings();
    }
    
    if (song != -1) && (abs(fmod_get_pos(play_sndchannel) - (tlpos+audioshift)) > 32) && (scroll_moving != 1)
    {
        fmod_set_pos(play_sndchannel,(tlpos+audioshift));
    }
}

if (frameprev != round(tlpos/1000*projectfps))
{
    frame_surf_refresh = 1;
    frameprev = round(tlpos/1000*projectfps);
}
    
   
if (controller.laseron)
{
    output_frame_seq_all();
	
	minroomspeed = 7.5; 
	_room_speed = projectfps/controller.fpsmultiplier;
	while (_room_speed < minroomspeed)
	    _room_speed += projectfps/controller.fpsmultiplier;
}
else 
    _room_speed = 60;

game_set_speed(_room_speed, gamespeed_fps);
    
//log("bm", get_timer() - timerbm);


