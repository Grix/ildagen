/// @description timing and laser output
if (room != rm_ilda) exit;

if (playing == 1)
{
    if (maxframes <= 1)
    {
        playing = 0;
        if (seqcontrol.song)
            FMODInstanceSetPaused(seqcontrol.songinstance,1);
    }
        
    framehr += delta_time/1000000*seqcontrol.projectfps*seqcontrol.playbackspeed;
    if (framehr > maxframes-0.5)
        framehr-= maxframes;
    frame = clamp(round(framehr),0,maxframes-1);
    if (frame < 1)
        frame = 0;
    if (frame != frameprev)
    {
        frame_surf_refresh = 1;
    }
    
    if !ds_list_empty(semaster_list)
    {
        update_semasterlist_flag = 1;
    }
        
    if (frameprev != 0) and (frame == 0) and (seqcontrol.song)
    {
        FMODInstanceSetPosition(seqcontrol.songinstance,tlx/seqcontrol.projectfps*1000/FMODSoundGetLength(seqcontrol.song));
    }
}

minroomspeed = 60;

if (laseron)
{
    if (!ds_exists(dac,ds_type_list))
    {
        show_message_new("Error, DAC data missing");
        laseron = false;
        dac = -1;
    }
    else
        output_frame();
}
else 
    fpsmultiplier = 1;

room_speed = projectfps/fpsmultiplier;
while (room_speed < minroomspeed)
    room_speed += projectfps/fpsmultiplier;

