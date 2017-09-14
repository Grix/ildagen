if (room != rm_seq) 
    exit;

if (view_current == 0)
{
    if ((alarm[0] == 1)) or (playing and (alarm[0] mod 2) == 1) or (moving_object) or (moving_object_flag) or (scroll_moving)
    {
        refresh_audio_surf();
    }
        
    draw_set_color(c_white);
    draw_set_alpha(1);
        
    //draws laser preview
    if  (!controller.laseron) and 
        ((frame_surf_refresh == 1) or !surface_exists(frame_surf) or !surface_exists(frame_surf_large) or !surface_exists(frame3d_surf_large) or !surface_exists(frame3d_surf))
    {
        if (largepreview)
            refresh_seq_surface_large();
        else
            refresh_seq_surface();
            
        frame_surf_refresh = false;
    }
        
    if (surface_exists(audio_surf))
        draw_surface_part(audio_surf,0,0,tlw+1,lbsh+17,0,137);
        
    draw_enable_alphablend(0);
    with (obj_button_parent)
        draw_self();
    draw_enable_alphablend(1);
        
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    cursorlinex = tlpos/1000*projectfps;
    cursorlinexdraw = (cursorlinex-tlx)/tlzoom*tlw;
    if (cursorlinexdraw == clamp(cursorlinexdraw,0,tlw))
    {
        //timeline cursor
        draw_line(cursorlinexdraw,136,cursorlinexdraw,136+tlh);
        draw_line(cursorlinexdraw,tls-1,cursorlinexdraw,lbsh+137);
        if (cursorlinexdraw > (tlw/2)) and (playing) and (!scroll_moving) and (!mouse_check_button(mb_any))
        {
            tlx = cursorlinex-(tlw/2)*tlzoom/tlw;
                if ((tlx+tlzoom) > length) length = tlx+tlzoom;
        }
    }
        
    draw_set_colour(c_teal);
    
    if (draw_mouseline = 1)
    {
        draw_set_alpha(0.2);
        draw_line(mouse_x,136,mouse_x,136+tlh);
        draw_line(mouse_x,tls,mouse_x,lbsh+136);
        draw_mouseline = 0;
    }
    if (draw_cursorline = 1)
    {
        draw_set_alpha(0.3);
        floatingcursorxcorrected = (floatingcursorx-tlx)/tlzoom*tlw;
        draw_line(floatingcursorxcorrected,floatingcursory,floatingcursorxcorrected,floatingcursory+48);
    }
        
    draw_set_alpha(1);
    if (controller.laseron)
    {
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(256,70,string_hash_to_newline("Laser output active: "+string(controller.dac[| 1])));
        draw_set_halign(fa_left);
    }
    else if (largepreview)
    {
        draw_set_colour(c_black);
        draw_rectangle(89,49,691,651,0);
        draw_set_color(c_white);
        
        if (viewmode != 0)
            draw_surface_part(frame3d_surf_large,0,0,600,600,90,50);
            
        if (viewmode != 1)
            draw_surface_part(frame_surf_large,0,0,600,600,90,50);
    }
    else
    {
        if (viewmode != 0)
            draw_surface_part(frame3d_surf,0,0,509,135,0,0);
            
        if (viewmode != 1)
            draw_surface_part(frame_surf,0,0,509,135,0,0);
    }
    
    draw_set_alpha(0.8);
    draw_set_color(c_ltgray);
    
    draw_text(12,115,string_hash_to_newline("Frame: "+string(frameprev-startframe+1)+"/"+string(endframe-startframe+1)));
    
    draw_text(12,7,string_hash_to_newline("FPS: "+string(projectfps)));
    if (playing && (fps != projectfps) && controller.laseron)
    {
        draw_set_color(c_red);
        draw_text(32,7,string_hash_to_newline("Warning: Dropping frames. Actual FPS: "+string(fps)));
    }
}
else if (view_current == 3)
{
    //menu
    draw_set_alpha(1);
    draw_set_colour(c_black);
    draw_text(0,__view_get( e__VW.YView, 3 )+4,string_hash_to_newline(menu_string));
    if (mouse_y > __view_get( e__VW.YView, 3 ))   
    {
        draw_set_colour(c_teal);
        if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
        {
            draw_rectangle(menu_width_start[0],__view_get( e__VW.YView, 3 )+1,menu_width_start[1],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[0],__view_get( e__VW.YView, 3 )+1,menu_width_start[1],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
        {
            draw_rectangle(menu_width_start[1],__view_get( e__VW.YView, 3 )+1,menu_width_start[2],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[1],__view_get( e__VW.YView, 3 )+1,menu_width_start[2],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
        {
            draw_rectangle(menu_width_start[2],__view_get( e__VW.YView, 3 )+1,menu_width_start[3],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[2],__view_get( e__VW.YView, 3 )+1,menu_width_start[3],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[3]) and (mouse_x < menu_width_start[4])
        {
            draw_rectangle(menu_width_start[3],__view_get( e__VW.YView, 3 )+1,menu_width_start[4],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[3],__view_get( e__VW.YView, 3 )+1,menu_width_start[4],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[4]) and (mouse_x < menu_width_start[5])
        {
            draw_rectangle(menu_width_start[4],__view_get( e__VW.YView, 3 )+1,menu_width_start[5],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[4],__view_get( e__VW.YView, 3 )+1,menu_width_start[5],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[5]) and (mouse_x < menu_width_start[6])
        {
            draw_rectangle(menu_width_start[5],__view_get( e__VW.YView, 3 )+1,menu_width_start[6],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[5],__view_get( e__VW.YView, 3 )+1,menu_width_start[6],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[6]) and (mouse_x < menu_width_start[7])
        {
            draw_rectangle(menu_width_start[6],__view_get( e__VW.YView, 3 )+1,menu_width_start[7],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[6],__view_get( e__VW.YView, 3 )+1,menu_width_start[7],__view_get( e__VW.YView, 3 )+20,0);
        }
        draw_set_alpha(1);
    }
}

