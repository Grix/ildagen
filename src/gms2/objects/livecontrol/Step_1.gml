/// @description timing and laser output
if (room != rm_live) exit;

if (playing == 1)
{
    framehr += delta_time/1000000*controller.projectfps;
    frame = round(framehr);
	
    if (frame != frameprev)
    {
        frame_surf_refresh = 1;
		for (i = 0; i < ds_list_size(filelist); i++)
		{
			if (!ds_list_find_value(filelist[| i], 0))
				continue;
			
			ds_list_set(ds_list_find_value(filelist[| i], 2), 0, ds_list_find_value(ds_list_find_value(filelist[| i], 2), 0)+(frame-frameprev));
			
			
			var t_pos = ds_list_find_value(ds_list_find_value(filelist[| i], 2), 0);
			var t_maxframes = ds_list_find_value(ds_list_find_value(filelist[| i], 2), 2);
			
			if (t_pos >= t_maxframes && t_maxframes > 1)
			|| (t_maxframes == 1) 
			{
				if (ds_list_find_value(filelist[| i], 4))
					ds_list_set(ds_list_find_value(filelist[| i], 2), 0, 0); //loop
				else
					ds_list_set(filelist[| i], 0, false); //stop
			}
		}
    }
}

frameprev = frame;

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

room_speed = controller.projectfps/controller.fpsmultiplier;
while (room_speed < minroomspeed)
    room_speed += controller.projectfps/controller.fpsmultiplier;
game_set_speed(room_speed, gamespeed_fps);


