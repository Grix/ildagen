/// @description timing and laser output
if (room != rm_seq) exit;

//var timerbm = get_timer();

if (playing == 1)
{
    var t_tlpos_prev = tlpos;
    tlpos += delta_time/1000*playbackspeed;
    
    if loop && (t_tlpos_prev <= endframe/projectfps*1000) && (tlpos > endframe/projectfps*1000) //if crossed the end marker
    {
        tlpos = startframe/projectfps*1000;
    }
    
    if song && (t_tlpos_prev <= length/projectfps*1000) && (tlpos > length/projectfps*1000)
    {
        //playing = 0;
        //tlpos = 0;
        if (song)
        {
            FMODInstanceStop(songinstance);
            songinstance = FMODSoundPlay(song,1);
            set_audio_speed();
        }
    }
    
    if (abs(FMODInstanceGetPosition(songinstance)*FMODSoundGetLength(song)-(tlpos+audioshift)) > 32) and (scroll_moving != 1) and (song)
    {
        FMODInstanceSetPosition(songinstance,(tlpos+audioshift)/FMODSoundGetLength(song));
    }
}

if (frameprev != round(tlpos/1000*projectfps))
{
    frame_surf_refresh = 1;
    frameprev = round(tlpos/1000*projectfps);
}
    
minroomspeed = 60; 
   
if (controller.laseron)
{
    output_frame_seq_all();
}

room_speed = projectfps;
while (room_speed < minroomspeed)
    room_speed += projectfps;
    
//log("bm", get_timer() - timerbm);


