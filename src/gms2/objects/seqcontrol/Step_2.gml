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
    FMODGMS_Sys_Update();

if (room != rm_seq) exit;
    
drawn = false;

if (instance_exists(obj_dropdown))
    exit;
    
if (keyboard_check(vk_control))
{
    //CTRL+*
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
    if (seqcontrol.song != 0)
    {
        if (playing)
        {
			FMODGMS_Chan_ResumeChannel(play_sndchannel);
            fmod_set_pos(play_sndchannel,clamp(((tlpos+audioshift)-10),0,songlength));
        }
        else
            FMODGMS_Chan_PauseChannel(play_sndchannel);
    }
}
    
else if (keyboard_check_pressed(vk_left)) and (tlpos > projectfps/1000)
{
    tlpos -= 1000/projectfps;
}

else if (keyboard_check_pressed(vk_tab))
{
    if (song != 0) 
		FMODGMS_Chan_PauseChannel(play_sndchannel);
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
    if (song != 0)
    {
        FMODGMS_Chan_StopChannel(play_sndchannel);
        FMODGMS_Snd_PlaySound(song, play_sndchannel);
        apply_audio_settings();
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



