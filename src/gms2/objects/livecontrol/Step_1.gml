/// @description timing and laser output
if (room != rm_live) exit;

if (playing == 1)
{
    if (maxframes <= 1)
    {
        playing = 0;
    }
        
    framehr += delta_time/1000000*controller.projectfps;
    if (framehr > maxframes-0.5)
        framehr -= maxframes;
    frame = clamp(round(framehr),0,maxframes-1);
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


