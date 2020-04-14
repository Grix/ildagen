//draws a preview of the element under construction

draw_set_color(c_gray);

if (placing == "font")
    exit;
	
var t_startx = startpos[0]/$ffff*view_wport[4];
var t_starty = camera_get_view_y(view_camera[4])+startpos[1]/$ffff*view_wport[4];

if (placing_status == 1)
{
    if (!keyboard_check(vk_shift))
    {
        endx = obj_cursor.x/view_wport[4]*$ffff;
        endy = obj_cursor.y/view_wport[4]*$ffff;
    }
    else
    {
        var t_theta = point_direction(t_startx,t_starty,mouse_x,mouse_y);
        if (t_theta > 315 || t_theta < 45 || (t_theta > 135 && t_theta < 225))
        {
            endx = obj_cursor.x/view_wport[4]*$ffff;
            endy = startpos[1];
        }
        else
        {
            endx = startpos[0];
            endy = obj_cursor.y/view_wport[4]*$ffff;
        }
    
    }
}

var t_endx = endx/$ffff*view_wport[4];
var t_endy = camera_get_view_y(view_camera[4])+endy/$ffff*view_wport[4];

if (placing == "line")
    draw_line_width(t_startx,t_starty,t_endx,t_endy, dpi_multiplier);
else if (placing == "rect")
    draw_rectangle(t_startx,t_starty,t_endx,t_endy,1);
else if (placing == "circle")
    draw_circle(t_startx,t_starty,point_distance(t_startx,t_starty,t_endx,t_endy),1);
//else if (placing == "hershey")
//    draw_surface(hershey_preview_surf,mouse_x-256,mouse_y-256);
else if (placing == "func")
{
    draw_circle(t_startx,t_starty,2,0);
    draw_text(t_startx+5,t_starty-10,"startx, starty");
    draw_text(obj_cursor.x+8,obj_cursor.y-10,"endx, endy");
}
else if (placing == "wave")
{
    cp = 20+5*wave_period;
    vector[0] = (t_endx-t_startx)/(cp-1);
    vector[1] = (t_endy-t_starty)/(cp-1);
    
    if (anienable)
    {
        if (maxframes > 1)
		{
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,frame/(maxframes-1)));
			wave_amp_r = lerp(wave_amp,aniwave_amp,frame/(maxframes-1));
		}
        else
		{
            wave_offset_r = degtorad(lerp(wave_offset,aniwave_offset,frame/63));
			wave_amp_r = lerp(wave_amp,aniwave_amp,frame/63);
		}
    }
    else
	{
        wave_offset_r = wave_offset;
		wave_amp_r = wave_amp;
	}
    
    for (i = 0; i < cp; i++)
    {
        ratiox = sin(degtorad(point_direction(t_startx,t_starty,t_endx,t_endy)));
        ratioy = cos(degtorad(point_direction(t_startx,t_starty,t_endx,t_endy)));
        pointx[i] = t_startx+vector[0]*i+wave_amp_r*2*sin(wave_offset_r+ pi*2/(cp-1)*i*wave_period)*ratiox/128;
        pointy[i] = t_starty+vector[1]*i+wave_amp_r*2*sin(wave_offset_r+ pi*2/(cp-1)*i*wave_period)*ratioy/128;
		// todo the amplitude is a little bit off, fix
    }
    for (i = 0; i < (cp-1); i++)
        draw_line(pointx[i],pointy[i],pointx[i+1],pointy[i+1]);
        
    if (mouse_wheel_up())
    {
        if !(keyboard_check_control())
            wave_amp += 128*3;
        else 
            wave_period += 0.5;
    }
    else if (mouse_wheel_down())
        if !(keyboard_check_control())
            wave_amp -= 128*3;
        else 
            wave_period -= 0.5;
            
    if (wave_period < 0.5) wave_period = 0.5;

}
else if (placing == "free")
{
    draw_line_width(t_startx+ ds_list_find_value(free_list,0)/$ffff*view_wport[4],
					t_starty+ ds_list_find_value(free_list,1)/$ffff*view_wport[4],
					t_startx,t_starty, dpi_multiplier);
					
    for (i=2; i < ds_list_size(free_list); i+= 2)
    {
        draw_line_width(t_startx+ ds_list_find_value(free_list,i)/$ffff*view_wport[4],
						t_starty+ ds_list_find_value(free_list,i+1)/$ffff*view_wport[4],
						t_startx+ ds_list_find_value(free_list,i-2)/$ffff*view_wport[4],
						t_starty+ ds_list_find_value(free_list,i-1)/$ffff*view_wport[4], dpi_multiplier);
    }
}
else if (placing == "curve")
{
	
    if (placing_status == 1)
    {
        draw_line_width(t_startx,t_starty,t_endx,t_endy, dpi_multiplier);
    }
    else
    {
		var t_mouse_y = (mouse_y - camera_get_view_y(view_camera[4]));
		var t_mouse_x = (mouse_x - camera_get_view_x(view_camera[4]));
        if  (point_distance(t_mouse_x,  t_mouse_y, ds_list_find_value(bez_list,2)/$ffff*view_wport[4], ds_list_find_value(bez_list,3)/$ffff*view_wport[4]) < 7*controller.dpi_multiplier) or
			(point_distance(t_mouse_x,  t_mouse_y, ds_list_find_value(bez_list,4)/$ffff*view_wport[4], ds_list_find_value(bez_list,5)/$ffff*view_wport[4]) < 7*controller.dpi_multiplier) or
			(point_distance(t_mouse_x,  t_mouse_y, ds_list_find_value(bez_list,0)/$ffff*view_wport[4], ds_list_find_value(bez_list,1)/$ffff*view_wport[4]) < 7*controller.dpi_multiplier) or
			(point_distance(t_mouse_x,  t_mouse_y, ds_list_find_value(bez_list,6)/$ffff*view_wport[4], ds_list_find_value(bez_list,7)/$ffff*view_wport[4]) < 7*controller.dpi_multiplier)
        {
            tooltip = "Click and drag to adjust curve."
        }
        else
        {
            tooltip = "Click and drag the green points to adjust curve. Press [Enter] to finalize curve."; 
        }
        
        if (bez_moving)
        {
            bezier_coeffs(	ds_list_find_value(bez_list,0),
							ds_list_find_value(bez_list,1),
							ds_list_find_value(bez_list,2),
							ds_list_find_value(bez_list,3),
							ds_list_find_value(bez_list,4),
							ds_list_find_value(bez_list,5),
							ds_list_find_value(bez_list,6),
							ds_list_find_value(bez_list,7));
        }
        tprevx = t_startx;
        tprevy = t_starty;
        
        bezlength = 0;
        for (i = 0;i < 15;i++)
        {
            tx = bezier_x(i/14)/$ffff*view_wport[4];
            ty = camera_get_view_y(view_camera[4])+bezier_y(i/14)/$ffff*view_wport[4];
            draw_line_width(tprevx,tprevy,tx,ty, dpi_multiplier);
            bezlength += point_distance(tprevx,tprevy,tx,ty)/view_wport[4]*$ffff;
            tprevx = tx;
            tprevy = ty;
        }
        
        draw_set_color(c_green);
        draw_rectangle(	ds_list_find_value(bez_list,0)/$ffff*view_wport[4]-2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,1)/$ffff*view_wport[4]-2*dpi_multiplier,
						ds_list_find_value(bez_list,0)/$ffff*view_wport[4]+2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,1)/$ffff*view_wport[4]+2*dpi_multiplier,0);
        draw_rectangle(	ds_list_find_value(bez_list,2)/$ffff*view_wport[4]-2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,3)/$ffff*view_wport[4]-2*dpi_multiplier,
						ds_list_find_value(bez_list,2)/$ffff*view_wport[4]+2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,3)/$ffff*view_wport[4]+2*dpi_multiplier,0);
        draw_rectangle(	ds_list_find_value(bez_list,4)/$ffff*view_wport[4]-2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,5)/$ffff*view_wport[4]-2*dpi_multiplier,
						ds_list_find_value(bez_list,4)/$ffff*view_wport[4]+2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,5)/$ffff*view_wport[4]+2*dpi_multiplier,0);
        draw_rectangle(	ds_list_find_value(bez_list,6)/$ffff*view_wport[4]-2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,7)/$ffff*view_wport[4]-2*dpi_multiplier,
						ds_list_find_value(bez_list,6)/$ffff*view_wport[4]+2*dpi_multiplier,
						camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,7)/$ffff*view_wport[4]+2*dpi_multiplier,0); 
        draw_line_width(	ds_list_find_value(bez_list,0)/$ffff*view_wport[4],
							camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,1)/$ffff*view_wport[4],
							ds_list_find_value(bez_list,2)/$ffff*view_wport[4],
							camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,3)/$ffff*view_wport[4], dpi_multiplier);
        draw_line_width(	ds_list_find_value(bez_list,4)/$ffff*view_wport[4],
							camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,5)/$ffff*view_wport[4],
							ds_list_find_value(bez_list,6)/$ffff*view_wport[4],
							camera_get_view_y(view_camera[4])+ds_list_find_value(bez_list,7)/$ffff*view_wport[4], dpi_multiplier);
    }
}
