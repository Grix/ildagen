if (room != rm_seq) 
    exit;

if (view_current == 1)
{
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
         
	var tlwdivtlzoom = tlw/tlzoom; //frames to pixels -> *
	
    //if ((alarm[0] == 1)) or (playing and (alarm[0] mod 2) == 1) or (moving_object) or (moving_object_flag) or (scroll_moving)

	refresh_timeline_surface();
	
    draw_timeline();
	
	draw_set_alpha(1);
	gpu_set_blendenable(false);
	gpu_set_alphatestenable(false);
    with (obj_button_parent)
        draw_self();
    
	gpu_set_blendenable(true);
	gpu_set_alphatestenable(true);
    if (controller.laseron)
    {
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(256,70,"Laser output active: "+string(controller.dac[| 1]));
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
    
    draw_text(12,115,"Frame: "+string(frameprev-startframe+1)+"/"+string(endframe-startframe+1));
    
    draw_text(12,7,"FPS: "+string(projectfps));
    if (playing && (fps != projectfps) && controller.laseron)
    {
        draw_set_color(c_red);
        draw_text(32,7,"Warning: Dropping frames. Actual FPS: "+string(fps));
    }
}
else if (view_current == 3)
{
    //menu
    draw_set_alpha(1);
    draw_set_colour(c_black);
    draw_text(0,__view_get( e__VW.YView, 3 )+4,menu_string);
    if (mouse_y > __view_get( e__VW.YView, 3 ) && scroll_moving == 0)   
    {
        draw_set_colour(c_teal);
        if (mouse_x > menu_width_start[0]) && (mouse_x < menu_width_start[1])
        {
            draw_rectangle(menu_width_start[0],__view_get( e__VW.YView, 3 )+1,menu_width_start[1],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[0],__view_get( e__VW.YView, 3 )+1,menu_width_start[1],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[1]) && (mouse_x < menu_width_start[2])
        {
            draw_rectangle(menu_width_start[1],__view_get( e__VW.YView, 3 )+1,menu_width_start[2],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[1],__view_get( e__VW.YView, 3 )+1,menu_width_start[2],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[2]) && (mouse_x < menu_width_start[3])
        {
            draw_rectangle(menu_width_start[2],__view_get( e__VW.YView, 3 )+1,menu_width_start[3],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[2],__view_get( e__VW.YView, 3 )+1,menu_width_start[3],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[3]) && (mouse_x < menu_width_start[4])
        {
            draw_rectangle(menu_width_start[3],__view_get( e__VW.YView, 3 )+1,menu_width_start[4],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[3],__view_get( e__VW.YView, 3 )+1,menu_width_start[4],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[4]) && (mouse_x < menu_width_start[5])
        {
            draw_rectangle(menu_width_start[4],__view_get( e__VW.YView, 3 )+1,menu_width_start[5],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[4],__view_get( e__VW.YView, 3 )+1,menu_width_start[5],__view_get( e__VW.YView, 3 )+20,0);
        }
        else if (mouse_x > menu_width_start[5]) && (mouse_x < menu_width_start[6])
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