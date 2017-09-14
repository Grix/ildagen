if (room == rm_loading)
{
    if (global.loading_exportproject == 1)
        export_project_work();
    else if (global.loading_saveproject == 1)
        save_project_work();
    else if (global.loading_loadproject == 1)
        load_project_work();
    else if (global.loading_importildaseq == 1)
    {
        
        if (global.loading_current < global.loading_end)
            read_ilda_work();
        else
            import_ildaseq_end();
    }
}

if (parsingaudio == 1) 
    refresh_audio();

if (song) 
    FMODUpdate();

if (room != rm_seq) exit;
    
drawn = false;

if (instance_exists(oDropDown))
    exit;
    
if (keyboard_check(vk_control))
{
    //CTRL+~
    if (keyboard_check_pressed(ord("C")))
    {
        if (!ds_list_empty(somaster_list))
        {
            //COPY
            seq_copy_object();
        }
    }
    else if (keyboard_check_pressed(ord("X")))
    {
        if (!ds_list_empty(somaster_list))
        {
            //COPY
            seq_cut_object();
        }
    }
    else if (keyboard_check_pressed(ord("V")))
    {
        if (selectedlayer >= 0) and (selectedx >= 0)
        {
            //COPY
            seq_paste_object();
        }
    }
    else if (keyboard_check_pressed(ord("Z")))
    {
        undo_seq();
    }
}

else if (keyboard_check_pressed(ord("S")))
{
    split_timelineobject();
}

else if (keyboard_check_pressed(vk_right))
{
    tlpos += 1000/projectfps;
}
    
else if (keyboard_check_pressed(vk_escape))
{
    if (controller.laseron)
    {
        controller.laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(controller.dac);
    }
}
    
else if (keyboard_check_pressed(vk_space))
{
    playing = !playing;
    if (seqcontrol.song)
    {
        if (playing)
        {
            FMODInstanceSetPosition(songinstance,(tlpos+audioshift)/FMODSoundGetLength(song));
            FMODInstanceSetPaused(songinstance,0);
        }
        else
            FMODInstanceSetPaused(songinstance,1);
    }
}
    
else if (keyboard_check_pressed(vk_left)) and (tlpos > projectfps/1000)
{
    tlpos -= 1000/projectfps;
}

else if (keyboard_check_pressed(vk_tab))
{
    if (song) FMODInstanceSetPaused(songinstance,1);
    playing = 0;
    room_goto(rm_ilda);
}
    
else if (keyboard_check_pressed(ord("P")))
{
    viewmode++;
    if (viewmode > 2)
        viewmode = 0;
    frame_surf_refresh = 1;
}
    
else if (keyboard_check_pressed(ord("0")))
{
    tlx = 0;
    playing = 0;
    tlpos = 0;
    if (song)
    {
        FMODInstanceStop(songinstance);
        songinstance = FMODSoundPlay(song,1);
        set_audio_speed();
    }
}

else if (keyboard_check_pressed(vk_delete))
{
    if (!ds_list_empty(somaster_list))
    {
        seq_delete_object();
    }
}
    
handle_mousecontrol();



