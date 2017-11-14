if (ex_patch_window_close_event())
    exit_confirm();

    
if (keyboard_check_pressed(ord("M")))
{
    window_set_fullscreen(0);
    window_set_size(default_window_w, default_window_h);
}
else if (keyboard_check_released(vk_f11))
    window_set_fullscreen(!window_get_fullscreen());
    
if (room == rm_loading)
{
    if (global.loading_exportilda == 1)
        export_ilda_work();
    else if (global.loading_exportildahtml5 == 1)
        export_ilda_html5_work();
    else if (global.loading_importilda == 1)
    {
        if (global.loading_current < global.loading_end)
            read_ilda_work();
        else
            import_ilda_end();
    }
    else if (global.loading_importfont == 1)
    {
        if (global.loading_current < global.loading_end)
            read_ilda_work();
        else
            import_font_end();
    }
}
    
if (room == rm_ilda) && (keyboard_check(ord("Z")) && !keyboard_check(vk_control))
{
    obj_cursor.image_index = 8;
    obj_cursor.x = clamp(mouse_x, 0, view_wport[4]);
    obj_cursor.y = clamp(mouse_y, 0, view_hport[4]);
	view_visible[5] = true;
	view_xport[5] = clamp(obj_cursor.x-128, 0, view_wport[4]-256);
	view_yport[5] = clamp(obj_cursor.y-128, 0, view_hport[4]-256 );
}
else
{
    obj_cursor.x = mouse_x;
    obj_cursor.y = mouse_y;
	view_visible[5] = false;
}

if (room != rm_ilda) 
	exit;

el_list = frame_list[| frame];

if (placing = "hershey")
    hershey_handle_scroll();
    
object_select_hovering = 0;

check_mouseactions();

if (keyboard_check_pressed(vk_space))
{
    playing = !playing;
    if (seqcontrol.song != -1)
    {
        if (playing)
        {
			FMODGMS_Chan_ResumeChannel(seqcontrol.play_sndchannel);
            fmod_set_pos(seqcontrol.play_sndchannel,clamp((tlx+framehr)/seqcontrol.projectfps*1000, 0, seqcontrol.songlength));
        }
        else
            FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
    }
    
    if (!playing)
        refresh_minitimeline_flag = 1;
}
    
else if (keyboard_check_pressed(vk_backspace))
{
    deselect_object();
}
    
else if (keyboard_check(vk_control) && keyboard_check_pressed(ord("Z")))
{
    undo_ilda();
}
        
else if (keyboard_check_pressed(ord("0")))
{
    ilda_cancel();
    frame = 0;
    framehr = 0;
    refresh_minitimeline_flag = 1;
}
    
else if (keyboard_check_pressed(ord("P")))
{
    viewmode++;
    if (viewmode > 2)
        viewmode = 0;
    frame_surf_refresh = 1;
}

else if (keyboard_check_pressed(vk_escape))
{
    ds_list_clear(semaster_list);
        
    if (laseron)
    {
        laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(dac);
    }
}
    
else if (keyboard_check(vk_control) || (placing == "select") || (highlight)) && ds_list_size(el_list)
{
    check_elementselect();
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("A")))
{
    dd_ilda_selectall();
}
    
//PASTE
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
{
    paste_object();
}
    
if (keyboard_check(ord("S"))) || (sgridshow == 1)
{
    with (obj_cursor)
    {
        if (x < view_wport[4]) && (y < view_wport[4])
            move_snap(view_wport[4]/controller.sgridnum, view_wport[4]/controller.sgridnum);
    }
}

if (ds_list_size(el_list) > 0)
{
    if (keyboard_check(vk_alt) && (placing_status == 0))
    {
        if (keyboard_check(vk_control))
        {
            obj_cursor.x = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),0)/$ffff*view_wport[4];
            obj_cursor.y = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),1)/$ffff*view_wport[4];
        }
        else
        {
            obj_cursor.x = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),2)/$ffff*view_wport[4];
            obj_cursor.y = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),3)/$ffff*view_wport[4];
        }
    }
    else if (keyboard_check(ord("Q")))
    {
        nearestdist = 32/512*view_wport[4];
        for (i = 0;i < ds_list_size(el_list);i++)
        {
            templist =  ds_list_find_value(el_list,i);
            if (point_distance(ds_list_find_value(templist,0)/$ffff*view_wport[4],ds_list_find_value(templist,1)/$ffff*view_wport[4],mouse_x,mouse_y) < nearestdist)
            {
                obj_cursor.x = ds_list_find_value(templist,0)/$ffff*view_wport[4];
                obj_cursor.y = ds_list_find_value(templist,1)/$ffff*view_wport[4];
                nearestdist = point_distance(ds_list_find_value(templist,0)/128,ds_list_find_value(templist,1)/$ffff*view_wport[4],mouse_x,mouse_y);
            }
            if (point_distance(ds_list_find_value(templist,2)/$ffff*view_wport[4],ds_list_find_value(templist,3)/128,mouse_x,mouse_y) < nearestdist)
            {
                obj_cursor.x = ds_list_find_value(templist,2)/$ffff*view_wport[4];
                obj_cursor.y = ds_list_find_value(templist,3)/$ffff*view_wport[4];
                nearestdist = point_distance(ds_list_find_value(templist,2)/$ffff*view_wport[4],ds_list_find_value(templist,3)/$ffff*view_wport[4],mouse_x,mouse_y);
            }
        }
        
    }
}
    
if (!surface_exists(frame_surf) || (!surface_exists(frame3d_surf) && viewmode != 0) || (highlight != keyboard_check(ord("H"))))
    frame_surf_refresh = true;

highlight = keyboard_check(ord("H"));
    
//SELECTED ELEMENT STUFFS
canrightclick = 1;
if !ds_list_empty(semaster_list)
{
    canrightclick = !handle_trans();
    
    //COPY
    if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C")))
    {
        copy_object();
    }
        
    //CUT
    else if (keyboard_check(vk_control) && keyboard_check_pressed(ord("X")))
    {
        cut_object();
    }
        
    //DELETE
    else if (keyboard_check_pressed(vk_delete))
    {
        delete_object();
    }
}

if (mouse_x == clamp(mouse_x,0,512)) && (mouse_y == clamp(mouse_y,0,512))
&& (mouse_check_button_pressed(mb_right)) && (canrightclick)
    dropdown_empty();
    
//KEYBOARD RIGHT LEFT
if (keyboard_check(vk_left)) && (maxframes > 1) && (placing_status == 0)
{
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    
    if (keyboard_check_pressed(vk_left))
    {
        frame--;
        framehr--;
        scroll = 0;
        alarm[0] = 30;
    }
    else if (scroll)
        framehr -= delta_time/1000000*seqcontrol.projectfps;
    if (framehr < -0.5)
        framehr+= maxframes;
    frame = round(framehr);
    if (frame < 1)
        frame = 0;
    frame_surf_refresh = 1;
    
    if !ds_list_empty(semaster_list)
    {
        update_semasterlist_flag = 1;
        
    }
    refresh_minitimeline_flag = 1;
}
else if (keyboard_check(vk_right)) && (maxframes > 1) && (placing_status == 0)
{
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    
    if (keyboard_check_pressed(vk_right))
    {
        frame++;
        framehr++;
        scroll = 0;
        alarm[0] = 30;
    }
    else if (scroll)
        framehr += delta_time/1000000*seqcontrol.projectfps;
    if (framehr > maxframes-0.5)
        framehr-= maxframes;
    frame = round(framehr);
    if (frame < 1)
        frame = 0;
    if (frame != frameprev)
        frame_surf_refresh = 1;
    
    if !ds_list_empty(semaster_list)
    {
        update_semasterlist_flag = 1;
    }
    refresh_minitimeline_flag = 1;
}
    
if (frame >= maxframes)
{
    frame = maxframes-1;
    framehr = maxframes-1;
}
    
frameprev = frame;    

//guidelines
if (keyboard_check(ord("A")) || (guidelineshow == 1))
{
    if  (keyboard_check_pressed(ord("A")))
    {
        if (guidelinedouble == 1)
            guidelineshow = !guidelineshow;
        alarm[5] = 30;
        guidelinedouble = 1;
    }
}
   
//grids 
if (keyboard_check(ord("S")) || (sgridshow == 1))
{
    if  (keyboard_check_pressed(ord("S")))
    {
        if (sgriddouble == 1)
            sgridshow = !sgridshow;
        alarm[2] = 30;
        sgriddouble = 1;
    }
    if (keyboard_check_pressed(vk_up))
    {
        controller.sgridnum -= 1;
        if (controller.sgridnum < 1)
            controller.sgridnum = 1;
        square_grid_refresh();
    }
    if (keyboard_check_pressed(vk_down))
    {
        controller.sgridnum += 1;
        square_grid_refresh();
    }
} 
if (keyboard_check(ord("R")) || (rgridshow == 1))
{
    if  (keyboard_check_pressed(ord("R")))
    {
        if (rgriddouble == 1)
            rgridshow = !rgridshow;
        alarm[1] = 30;
        rgriddouble = 1;
    }
}

if (keyboard_check_pressed(vk_tab))
{
    if (os_browser != browser_not_a_browser)
    {
        show_message_new("Sorry, the timeline is not available in the web version yet");
        exit;
    }
    ilda_cancel();
    frame = 0;
    framehr = 0;
    if (seqcontrol.song != -1)
        FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
        
    room_goto(rm_seq);
}

