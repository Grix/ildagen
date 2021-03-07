function check_mouseactions() {
	show_framecursor_prev = false;

	if (maxframes < 2) 
		exit;

	if (scope_moving)
	{
	    refresh_minitimeline_flag = true;
	    show_framecursor_prev = true;
	    framecursor_prev = round(lerp(0,maxframes-1, (mouse_x-tlorigo_x)/(tlw-tlorigo_x)));
	    scope_end = framecursor_prev;
	    if (!mouse_check_button(mb_left))
	    {
	        scope_moving = false;
	        if (scope_end < scope_start)
	        {
	            var t_scope_end = scope_end;
	            scope_end = scope_start;
	            scope_start = t_scope_end;
	        }
	        if ( (scope_start < 0) || (scope_start == scope_end) || (scope_end > maxframes-1))
	        {
	            scope_start = 0;
	            scope_end = maxframes-1;
	        }
	    }
	    exit;
	}
	
	if (objmoving != 0 || bez_moving != 0)
		exit;

	if ((mouse_x > tlorigo_x+2) && (mouse_x < tlorigo_x+tlw-2) && 
	    (mouse_y > tlorigo_y) && (mouse_y < tlorigo_y + tlh))
	{
	    tooltip = "Click to jump to this frame. Hold Shift and drag mouse to set editing scope.";
	    framecursor_prev = round(lerp(0,maxframes-1, (mouse_x-tlorigo_x)/(tlw-tlorigo_x)));
	    show_framecursor_prev = true;
	    if (mouse_check_button(mb_left))
	    {
	        if (keyboard_check(vk_shift))
	        {
	            scope_start = framecursor_prev;
	            scope_moving = true;
	        }
	        else
	        {
	            framehr = framecursor_prev;
	            frame = framecursor_prev;
            
	            frame_surf_refresh = 1;
	            update_semasterlist_flag = 1;
	            refresh_minitimeline_flag = 1;
			
				with (seqcontrol)
				{
			        if (song != -1)
			        {
			            FMODGMS_Chan_StopChannel(play_sndchannel);
			            FMODGMS_Snd_PlaySound(song, play_sndchannel);
			            apply_audio_settings();
						if (controller.playing)
							FMODGMS_Chan_ResumeChannel(play_sndchannel);
						else
							FMODGMS_Chan_PauseChannel(play_sndchannel);
			            fmod_set_pos(play_sndchannel,clamp(((selectedx+controller.frame)/projectfps*1000+audioshift)-10, 0, songlength));
			        }
				}
	        }
	    }
	}

}
