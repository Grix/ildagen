/// @description timing and laser output
if (room != rm_live) exit;

if (playing == 1)
{
    framehr += delta_time/1000000*controller.projectfps;
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
			
			if (t_objectlist[| 7] != 0)
			{
				if (keyboard_check(t_objectlist[| 3]) || t_objectlist[| 7] == 2)
					t_objectlist[| 0] = true;
				else
				{
					t_objectlist[| 0] = false;
					if (!t_objectlist[| 6])
						t_objectlist[| 2][| 0] = 0; // restart if not set to resume
				}
				
				t_objectlist[| 7] = 1;
			}
			
			if (!ds_list_find_value(t_objectlist, 0))
				continue;
			
			ds_list_set(ds_list_find_value(t_objectlist, 2), 0, ds_list_find_value(ds_list_find_value(t_objectlist, 2), 0)+(frame-frameprev));
			
			
			var t_pos = ds_list_find_value(ds_list_find_value(t_objectlist, 2), 0);
			var t_maxframes = ds_list_find_value(ds_list_find_value(t_objectlist, 2), 2);
			
			if (t_pos >= t_maxframes && t_maxframes > 1)
			|| (t_maxframes == 1) 
			{
				if (ds_list_find_value(t_objectlist, 4))
					ds_list_set(ds_list_find_value(t_objectlist, 2), 0, 0); //loop
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

minroomspeed = 7.5;

if (controller.laseron)
{
    if (!ds_list_exists(controller.dac))
    {
        show_message_new("Error, DAC data missing");
        controller.laseron = false;
        controller.dac = -1;
    }
    else
        output_frame_live();
}
else 
    controller.fpsmultiplier = 1;

_room_speed = controller.projectfps/controller.fpsmultiplier;
while (_room_speed < minroomspeed)
    _room_speed += controller.projectfps/controller.fpsmultiplier;
game_set_speed(_room_speed, gamespeed_fps);


