/// @description timing and laser output
if (room != rm_live) exit;

//var timerbm = get_timer();

if 1//(frameprev != round(deltatime/1000*projectfps))
{
    frame_surf_refresh = 1;
    //frameprev = round(tlpos/1000*projectfps);
}
    
minroomspeed = 60; 
   
if (controller.laseron)
{
    //output_frame_live();
}

room_speed = controller.projectfps;
while (room_speed < minroomspeed)
    room_speed += controller.projectfps;
game_set_speed(room_speed, gamespeed_fps);
    
//log("bm", get_timer() - timerbm);


