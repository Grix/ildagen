/// @description timing and laser output
if (room != rm_live) exit;

if (playing == 1)
{
    framehr += delta_time/1000000*controller.projectfps;
	
	var t_maxframes = 1;
	if (playingfile >= 0 && playingfile < ds_list_size(filelist))
	{
		var t_objectlist = filelist[| playingfile];
		var t_infolist = t_objectlist[| 2];
		t_maxframes = t_infolist[| 2];
	}
	
    if (framehr > t_maxframes-0.5)
        framehr -= t_maxframes;
    frame = clamp(round(framehr),0,t_maxframes-1);
    if (frame != frameprev)
    {
        frame_surf_refresh = 1;
    }
}

minroomspeed = 60;

if (controller.laseron)
{
    if (!ds_exists(controller.dac,ds_type_list))
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


