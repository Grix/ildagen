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
    parse_audio();

if (song != -1) 
    FMODGMS_Sys_Update();

if (room != rm_seq) exit;

var t_windowwidth = window_get_width();
var t_windowheight = window_get_height();

if (t_windowheight != (view_hport[3]+view_hport[4]+view_hport[1]) || t_windowwidth != view_wport[3])
&& !(t_windowheight == 0 || t_windowwidth == 0)
|| controller.forceresize
{
	//if (t_windowheight < controller.default_window_h || t_windowwidth < controller.default_window_w)
	//	window_set_size(controller.default_window_w, controller.default_window_h);
	
	if (controller.dpi_scaling == 0 || controller.dpi_scaling == -1)
		controller.dpi_multiplier = min( ceil(window_get_height()/(735*2.05)), ceil(window_get_width()/(1350*2)) );
	
	log("Resized window");
	controller.forceresize = false;
	
	view_hport[3] = 23*controller.dpi_multiplier;
	view_hport[0] = 706*controller.dpi_multiplier;
	view_wport[0] = 315*controller.dpi_multiplier;
	view_wport[1] = max(t_windowwidth-view_wport[0], 1);
	view_wport[4] = view_wport[1];
	view_hport[4] = (t_windowheight-view_hport[3])*0.2*(power(t_windowheight/view_hport[0], 0.8));
	view_hport[1] = t_windowheight-view_hport[3]-view_hport[4];
	view_yport[4] = view_hport[3];
	view_yport[0] = view_hport[3];
	view_yport[1] = view_hport[4]+view_hport[3];
	view_xport[0] = view_wport[1];
	//view_wport[6] = view_wport[0];
	//view_hport[6] = max(t_windowheight-view_hport[3]-view_hport[0], 1);
	//view_xport[6] = view_xport[0];
	//view_yport[6] = view_hport[3]+view_hport[0];
	view_wport[3] = t_windowwidth;
	view_yport[3] = 0;
	//camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	camera_set_view_pos(view_camera[1], 0, view_hport[3]+view_hport[4]);
	camera_set_view_size(view_camera[3], view_wport[3]/controller.dpi_multiplier, view_hport[3]/controller.dpi_multiplier);
	camera_set_view_size(view_camera[4], view_wport[4], view_hport[4]);
	camera_set_view_size(view_camera[1], view_wport[1]/controller.dpi_multiplier, view_hport[1]/controller.dpi_multiplier);
	//camera_set_view_size(view_camera[6], view_wport[6], view_hport[6]);
	//camera_set_view_pos(view_camera[6], 987, camera_get_view_y(view_camera[0])+view_yport[6]-view_hport[3]);
	tlsurf_y = camera_get_view_y(view_camera[1]);
	tlw = view_wport[1]/controller.dpi_multiplier;
	tlh = 128-16;
	tls = tlh+tlsurf_y+16; //start of layer area, seen from outside surface
	lbh = view_hport[1]/controller.dpi_multiplier-16-18-tlh;
	lbsh = tlh+18+lbh; //start of bottom scrollbar, seen from inside surface
	tlhalf = tlh/2;
	tlthird = tlh/3;
	timeline_surf_length = 0;
	
	if (instance_exists(inst_quicktip_seq))
		inst_quicktip_seq.y = camera_get_view_y(view_camera[1])+250;
	
	free_scalable_surfaces();
}

if (instance_exists(obj_dropdown))
    exit;
    
if (keyboard_check_control())
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
            //CUT
            seq_cut_object();
        }
    }
    else if (keyboard_check_pressed(ord("V")))
    {
        if (selectedlayer >= 0) and (selectedx >= 0)
        {
            //PASTE
            seq_paste_object();
        }
    }
    else if (keyboard_check_pressed(ord("Z")))
    {
        undo_seq();
    }
	else if (keyboard_check_pressed(ord("Y")))
    {
        redo_seq();
    }
}

else if (keyboard_check_pressed(ord("S")))
{
    split_timelineobject();
}

else if (keyboard_check_pressed(ord("R")))
{
    reverse_timelineobject();
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
        dac_blank_and_center_all();
    }
}
    
else if (keyboard_check_pressed(vk_space))
{
    playing = !playing;
    if (seqcontrol.song != -1)
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
    if (song != -1) 
		FMODGMS_Chan_PauseChannel(play_sndchannel);
    playing = 0;
	if (controller.tab_cycles_all == 1)
		room_goto(rm_live);
	else
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
    if (song != -1)
    {
        FMODGMS_Chan_StopChannel(play_sndchannel);
        FMODGMS_Snd_PlaySound(song, play_sndchannel);
        apply_audio_settings();
    }
}

if (largepreview)
	exit;

else if (keyboard_check_pressed(vk_delete))
{
    if (!ds_list_empty(somaster_list))
    {
        seq_delete_object();
    }
}
    
handle_mousecontrol_seq();



