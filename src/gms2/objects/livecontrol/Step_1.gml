/// @description timing and laser output
if (room != rm_live) exit;

if (playing == 1)
{
	var t_speed_adjust = speed_adjusted;
	if (controller.use_bpm)
		t_speed_adjust = bpm_adjusted / controller.bpm;
		
	var t_deltaframe = delta_time/1000000*controller.projectfps * t_speed_adjust;
	if (!controller.laseron || (fps_real-10 < fps) || t_deltaframe >= 1.99*controller.fpsmultiplier)
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
	
    frame = round(framehr);
	
	if (frameprev > frame)
		frameprev = frame;
	
	frametotal = frame;
	frametotalhr = framehr;
	
    if (frame != frameprev)
    {
        frame_surf_refresh = 1;
		for (i = 0; i < ds_list_size(filelist); i++)
		{
			var t_objectlist = filelist[| i];
			
			if (t_objectlist[| 10] != 0)
			{
				if ((keyboard_check(t_objectlist[| 6]) && t_objectlist[| 6] > 0) || t_objectlist[| 10] == 2 || ds_list_find_index(midi_keys_pressed, t_objectlist[| 13]) != -1)
					t_objectlist[| 0] = true;
				else
				{
					t_objectlist[| 0] = false;
					if (!t_objectlist[| 9])
						t_objectlist[| 2] = 0; // restart if not set to resume
				}
				
				t_objectlist[| 10] = 1;
			}
			
			if (!ds_list_find_value(t_objectlist, 0))
				continue;
			
			ds_list_set(t_objectlist, 2, ds_list_find_value(t_objectlist, 2)+(frame-frameprev));
			
			
			var t_pos = ds_list_find_value(t_objectlist, 2);
			var t_maxframes = ds_list_find_value(t_objectlist, 4);
			
			if (t_pos >= t_maxframes && t_maxframes > 1)
			|| (t_maxframes == 1) 
			{
				if (ds_list_find_value(t_objectlist, 7))
					ds_list_set(t_objectlist, 2, 0); //loop
				else
					ds_list_set(t_objectlist, 0, false); //stop
			}
		}
    }
}
else
{
	frametotalhr += delta_time/1000000*controller.projectfps;
    frametotal = round(frametotalhr);
	if (frametotal != frameprev)
    {
		frame_surf_refresh = 1;
	}
}

frameprev = frametotal;



if (controller.laseron)
{
    if (!ds_list_exists_pool(controller.dac))
    {
        show_message_new("Error, DAC data missing");
        controller.laseron = false;
        controller.dac = -1;
    }
    else
        output_frame_live();
		
	minroomspeed = 7.5;
	_room_speed = controller.projectfps/controller.fpsmultiplier;
	while (_room_speed < minroomspeed)
		_room_speed += controller.projectfps/controller.fpsmultiplier;
}
else 
    _room_speed = 60;

if (game_get_speed(gamespeed_fps) != _room_speed)
	game_set_speed(_room_speed, gamespeed_fps);


