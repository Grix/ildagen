if (room != rm_ilda) 
    exit;
	
	
if (view_current == 4 || view_current == 5)
{   
    //mini timeline + cursors
    if (!surface_exists(minitimeline_surf) || refresh_minitimeline_flag)
    {
        refresh_minitimeline_surf();
        refresh_minitimeline_flag = 0;
    }
	gpu_set_blendenable(false);
	
	draw_clear(c_black);
	
    if (surface_exists(minitimeline_surf))
        draw_surface_part_ext(minitimeline_surf,0,0,tlw,tlh+1,tlorigo_x,tlorigo_y, dpi_multiplier, dpi_multiplier, c_white, 1);
	
	gpu_set_blendenable(true);
	
    if (maxframes > 1)
    {
        cursorlinex = lerp(2,tlw-2,frame/(maxframes-1));
        draw_line(cursorlinex,tlorigo_y,cursorlinex,tlorigo_y+tlh-13);
        if (show_framecursor_prev)
        {
            draw_set_alpha(0.6);
            draw_set_color(c_teal);
            cursorlinex = lerp(2,tlw-2,framecursor_prev/(maxframes-1));
            draw_line(cursorlinex,tlorigo_y,cursorlinex,tlorigo_y+tlh);
            draw_set_alpha(1);
        }
    }
    draw_set_color(c_white);
    
    //frame box
    draw_ilda_2d();
	
	var t_y = camera_get_view_y(view_camera[4]);
    
    if (!laseron)
    {
        if (bckimage)
        {
            if (!keyboard_check(ord("E")))
                draw_set_alpha(0.3);
            if (sprite_exists(bck_bckimage))
            {
                draw_sprite_stretched(bck_bckimage,0,bckimage_left*view_wport[4],t_y+bckimage_top*view_hport[4],bckimage_width*view_wport[4],bckimage_height*view_wport[4]);
            }
            else bckimage = 0;
        }
        
        if (object_select_hovering = 1)
        {
            draw_set_alpha(0.5);
            draw_set_colour(c_teal);
                draw_rectangle(rectxmin2,t_y+rectymin2,rectxmax2,t_y+rectymax2,1);
            draw_set_alpha(1);
            draw_set_colour(c_white);
        }
        else if (object_select_hovering = 2)
        {
            draw_set_alpha(0.7);
            draw_set_colour(c_maroon);
                draw_rectangle(rectxmin2,t_y+rectymin2,rectxmax2,t_y+rectymax2,1);
            draw_set_alpha(1);
            draw_set_colour(c_white);
        }
        
        draw_set_color(c_gray);
        if (objmoving == 3)
            draw_text(20,t_y+20,string_format(anirot,3,2)+" deg");
        else if (objmoving == 1)
        {
            draw_text(20,t_y+20,"X translation: "+string_format(anixtrans,5,0));
            draw_text(20,t_y+40,"Y translation: "+string_format(aniytrans,5,0));
        }
        else if (objmoving == 2)
        {
            draw_text(20,t_y+20,"Anchor X: "+string_format(anchorx,5,0));
            draw_text(20,t_y+40,"Anchor Y: "+string_format(anchory,5,0));
        }
        else if (objmoving == 4)
        {
            draw_text(20,t_y+20,"X scale: "+string_format(scalex,2,3));
            draw_text(20,t_y+40,"Y scale: "+string_format(scaley,2,3));
        }
        draw_set_color(c_white);
            
        draw_set_alpha(0.7);
           
        //grids 
        if (keyboard_check(ord("S")) || (sgridshow == 1))
        {
            if (!surface_exists(squaregrid_surf))
            {
                squaregrid_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_wport[4]))));
                surface_set_target(squaregrid_surf);
                    draw_grid();
                surface_reset_target();
            }
            draw_surface_part(squaregrid_surf,0,0, view_wport[4], view_wport[4], 0, t_y);
        } 
        if (keyboard_check(ord("R")) || (rgridshow == 1))
        {
            if (!surface_exists(radialgrid_surf))
            {
                radialgrid_surf = surface_create(power(2, ceil(log2(view_wport[4]))), power(2, ceil(log2(view_wport[4]))));
                surface_set_target(radialgrid_surf);
                    draw_radialgrid();
                surface_reset_target();
            }
            draw_surface_part(radialgrid_surf,0,0, view_wport[4], view_wport[4], 0, t_y);
        }
            
        if ((keyboard_check(ord("A")) && !keyboard_check_control()) || (guidelineshow == 1))
        {
            draw_guidelines();
        }
		
		var t_scale = $ffff/view_wport[4];
        
        draw_set_alpha(1);
        draw_set_color(c_gray);
        if (highlight)
        {
            for (u = 0; u < ds_list_size(el_list);u++)
            {
                templist = ds_list_find_value(el_list,u);
                
                xo = ds_list_find_value(templist,0)/t_scale;
                yo = ds_list_find_value(templist,1)/t_scale;
                
                xp1 = xo+ds_list_find_value(templist,4)/t_scale;
                yp1 = yo+ds_list_find_value(templist,6)/t_scale;
                xp2 = xo+ds_list_find_value(templist,5)/t_scale;
                yp2 = yo+ds_list_find_value(templist,7)/t_scale;
                draw_rectangle(xp1,t_y+yp1,xp2,t_y+yp2,1);
            }
        }
        
        //selected elements
        draw_set_color(c_aqua);
        if !(ds_list_empty(semaster_list))
        {
            
            draw_sprite(spr_anchor,0,round(anchorx/t_scale), round(t_y+anchory/t_scale));
            draw_set_alpha(0.6);
            draw_sprite(spr_rotate,0,clamp(rectxmin/t_scale, 22, view_wport[4]), clamp(t_y+rectymax/t_scale, t_y, t_y+view_wport[4]-22));
            draw_sprite(spr_resize,0,clamp(rectxmax/t_scale, 0, view_wport[4]-22), clamp(t_y+rectymax/t_scale, t_y, t_y+view_wport[4]-22));
            draw_set_alpha(1);
            
            draw_rectangle(rectxmin/t_scale, t_y+rectymin/t_scale, rectxmax/t_scale, t_y+rectymax/t_scale,1);
            
            if (objmoving == 1) || (objmoving == 3) || (objmoving == 4)
            {
				
                xp1 = rectxmin+anixtrans;
                yp1 = rectymin+aniytrans;
                xp2 = rectxmax+anixtrans;
                yp2 = rectymax+aniytrans;
                xp3 = rectxmax+anixtrans;
                yp3 = rectymin+aniytrans;
                xp4 = rectxmin+anixtrans;
                yp4 = rectymax+aniytrans;
                rot_r = degtorad(anirot);
                
                angle1 = degtorad(point_direction(anchorx,anchory,xp1,yp1));
                dist1 = point_distance(anchorx,anchory,xp1,yp1);
                
                xpnew1 = anchorx+cos(rot_r-angle1)*dist1*scalex;
                ypnew1 = anchory+sin(rot_r-angle1)*dist1*scaley;
                
                angle2 = degtorad(point_direction(anchorx,anchory,xp2,yp2));
                dist2 = point_distance(anchorx,anchory,xp2,yp2);
                
                xpnew2 = anchorx+cos(rot_r-angle2)*dist2*scalex;
                ypnew2 = anchory+sin(rot_r-angle2)*dist2*scaley;
        
                angle3 = degtorad(point_direction(anchorx,anchory,xp3,yp3));
                dist3 = point_distance(anchorx,anchory,xp3,yp3);
                
                xpnew3 = anchorx+cos(rot_r-angle3)*dist3*scalex;
                ypnew3 = anchory+sin(rot_r-angle3)*dist3*scaley;
                
                angle4 = degtorad(point_direction(anchorx,anchory,xp4,yp4));
                dist4 = point_distance(anchorx,anchory,xp4,yp4);
                
                xpnew4 = anchorx+cos(rot_r-angle4)*dist4*scalex;
                ypnew4 = anchory+sin(rot_r-angle4)*dist4*scaley;
                
        
                draw_set_color(c_teal);
                draw_rectangle(xp1/t_scale, t_y+yp1/t_scale, xp2/t_scale, t_y+yp2/t_scale,1);
                
				draw_set_alpha(0.4);
                draw_line(xpnew1/t_scale, t_y+ypnew1/t_scale, xpnew3/t_scale, t_y+ypnew3/t_scale);
                draw_line(xpnew2/t_scale, t_y+ypnew2/t_scale, xpnew3/t_scale, t_y+ypnew3/t_scale);
                draw_line(xpnew2/t_scale, t_y+ypnew2/t_scale, xpnew4/t_scale, t_y+ypnew4/t_scale);
                draw_line(xpnew4/t_scale, t_y+ypnew4/t_scale, xpnew1/t_scale, t_y+ypnew1/t_scale);
            
                if (objmoving == 1)
                {
                    draw_arrow(	mean(rectxmin/t_scale, rectxmax/t_scale), t_y+mean(rectymin/t_scale,rectymax/t_scale),
								mean(xpnew1/t_scale, xpnew2/t_scale), t_y+mean(ypnew1/t_scale,ypnew2/t_scale),12);
                }
				
				draw_set_alpha(1);
            }
            
        }
        
        if (placing_status) || (placing == "text") || (placing == "hershey") 
            draw_preview_element();
    }
    
    //info text
    draw_set_alpha(0.8);
    draw_set_font(fnt_tooltip);
    
        draw_set_color(c_ltgray);
        draw_text(12, t_y+view_wport[4]-20, "Frame: "+string(frame+1)+"/"+string(maxframes));
        
        draw_text(12,t_y+7,"FPS: "+string(projectfps/controller.fpsmultiplier));
        if (playing && (fps != projectfps/fpsmultiplier) && laseron)
        {
            draw_set_color(c_red);
            draw_text(32,t_y+7,"Warning: Dropping frames. Actual FPS: "+string(fps));
        }
        
        if (frame_complexity == 1)
            draw_set_color(c_red);
        else if (frame_complexity == 2)
            draw_set_color(c_orange);
        else 
            draw_set_color(c_ltgray);
        draw_text(view_wport[4]-70, t_y+view_wport[4]-20, "Points: "+string(framepoints));
        
        if (!anienable) && (maxframes < 2)
            draw_set_color(c_gray);
        else 
            draw_set_color(c_ltgray);
        if (scope_start == 0) && (scope_end == maxframes-1)
            draw_text(view_wport[4]/2-34, t_y+view_wport[4]-20, "Scope: All frames");
        else
            draw_text(view_wport[4]/2-34, t_y+view_wport[4]-20, "Scope: "+string(scope_start+1)+" - "+string(scope_end+1));
			
	draw_set_color(c_black);
	draw_set_alpha(1);
}
else if (view_current == 0)
{
	
    gpu_set_blendenable(false);
	
	//draw_clear(c_ltltgray);
	
	//hershey symbol selector
    if (placing = "hershey")
    {
        draw_sprite_part(bck_hershey3,0,0,clamp(hershey_scrollx-4096,0,2048),420,120-clamp(4096-hershey_scrollx,0,120),650,30+clamp(4096-hershey_scrollx,0,120));
        draw_sprite_part(bck_hershey2,0,0,clamp(hershey_scrollx-2048,0,2048),420,120-clamp(2048-hershey_scrollx,0,120),650,30+clamp(2048-hershey_scrollx,0,120));
        draw_sprite_part(bck_hershey1,0,0,clamp(hershey_scrollx,0,2048),420,120,650,30);
        
        draw_set_colour(c_white);
        draw_rectangle(1070,30,1090,150,0);
        draw_set_colour(c_black);
        draw_rectangle(1070,30,1090,150,1);
        draw_set_colour(c_dkgray);
        draw_rectangle(1070,30+hershey_scrollx*100/hershey_scrollh,1090,30+hershey_scrollx*100/hershey_scrollh+hershey_scrollw,0);
        
		gpu_set_blendenable(true);
		
        yo = ceil((hershey_selected+1)/14)*30-30;
        if (yo = clamp(yo,hershey_scrollx-30,hershey_scrollx+120))
        {
            draw_set_alpha(0.3)
            draw_set_color(c_gold);
            xo = (hershey_selected mod 14)*30;
            draw_rectangle(650+xo,max(30+yo-hershey_scrollx,30),680+xo,min(30+yo-hershey_scrollx+30,150),0);
			draw_set_alpha(1);
        }
		gpu_set_blendenable(false);
    }
	
	//separator lines
	draw_set_color(c_white);
	var t_w4 = 512;//view_wport[4];
	var t_h4 = view_hport[4]; //	var t_h4 = 512+tlh+3;
	var t_h0 = view_hport[0];
	var t_w0w4 = view_wport[0]+t_w4;
	draw_line(t_w4+10, 171, t_w0w4-10, 171);
	draw_line(t_w4+10, 343, t_w0w4-10, 343);
	draw_line(t_w4+10, 513, t_w0w4-10, 513);
	draw_line(1117, 522, 1117, t_h0-10);
	draw_line(835, 522, 835, t_h0-10);
	draw_set_color(c_ltgray);
	draw_line(t_w4+10, 170, t_w0w4-10, 170);
	draw_line(t_w4+10, 342, t_w0w4-10, 342);
	draw_line(t_w4+10, 512, t_w0w4-10, 512);
	draw_line(1116, 522, 1116, t_h0-10);
	draw_line(834, 522, 834, t_h0-10);
	/*draw_set_color(c_gold);
	draw_line(t_w4+1, -1, t_w4+1, t_h4+1);
	draw_set_color(c_black);
	draw_line(t_w4, -1, t_w4, t_h4);
	draw_line(t_w4+2, -1, t_w4+2, t_h4+2);
	draw_line(t_w4-1, t_h4+2, t_w4+2, t_h4+2);*/
	
    with (obj_section0_parent)
    {
		if (!transparent && !visible)
		{
			if (_visible)
				draw_self();
		}
    }
	
    gpu_set_blendenable(true);
}
else if (view_current == 1)
{
	gpu_set_blendenable(false);
	
	//draw_clear(c_green);
	
	//separator lines
	var t_h4 = camera_get_view_y(view_camera[1]);
	var t_w1 = camera_get_view_width(view_camera[1]);
	var t_h0 = view_hport[1]+t_h4;
	draw_set_color(c_white);
	draw_line(t_w1-1, t_h4+10, t_w1-1, t_h0-10);
	draw_set_color(c_ltgray);
	draw_line(t_w1-2, t_h4+10, t_w1-2, t_h0-10);
	/*draw_set_color(c_gold);
	draw_line(-1, t_h4+1, t_w1, t_h4+1);*/
	//draw_set_color(c_black);
	//draw_line(-1, t_h4, t_w1, t_h4);
	//draw_line(-1, t_h4+2, t_w1, t_h4+2);
	
    with (obj_section1_parent)
    {
		if (!transparent && !visible)
		{
			if (_visible)
				draw_self();
		}
    }
    gpu_set_blendenable(true);
}
else if (view_current == 3)
{
    draw_set_colour(c_black);
	var t_ypos = camera_get_view_y(view_camera[3]);
	var t_height = camera_get_view_height(view_camera[3]);
	
	//gpu_set_blendenable(false);
	//draw_clear(c_ltltgray);
	draw_line(-1, t_ypos+t_height-1, view_wport[3], t_ypos+t_height-1);
    //gpu_set_blendenable(true);
	
    //menu
    draw_text(0, t_ypos+4,menu_string);
    if (mouse_y < 0)
    {
        draw_set_colour(c_teal);
        if (mouse_x > menu_width_start[0]) && (mouse_x < menu_width_start[1])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[0], t_ypos+1,menu_width_start[1], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[0], t_ypos+1,menu_width_start[1], t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[1]) && (mouse_x < menu_width_start[2])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[1], t_ypos+1,menu_width_start[2], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[1], t_ypos+1,menu_width_start[2], t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[2]) && (mouse_x < menu_width_start[3])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[2], t_ypos+1,menu_width_start[3], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[2], t_ypos+1,menu_width_start[3], t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[3]) && (mouse_x < menu_width_start[4])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[3], t_ypos+1,menu_width_start[4], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[3], t_ypos+1,menu_width_start[4], t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[4]) && (mouse_x < menu_width_start[5])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[4], t_ypos+1,menu_width_start[5], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[4], t_ypos+1,menu_width_start[5], t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[5]) && (mouse_x < menu_width_start[6])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[5], t_ypos+1,menu_width_start[6], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[5], t_ypos+1,menu_width_start[6], t_ypos+t_height-3,0);
        }
        else if (mouse_x > menu_width_start[6]) && (mouse_x < menu_width_start[7])
        {
			tooltip = ".";
            draw_rectangle(menu_width_start[6], t_ypos+1,menu_width_start[7], t_ypos+t_height-3,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[6], t_ypos+1,menu_width_start[7], t_ypos+t_height-3,0);
        }
        draw_set_alpha(1);
    }
}
else if (view_current == 6)
{
	gpu_set_blendenable(false);
	draw_clear(c_ltltgray);
	
	//separator lines
	var t_w4 = 512;
	var t_h4 = view_hport[4];
	var t_w0w4 = view_wport[0]+t_w4;
	var t_h0 = view_hport[0];
	/*draw_set_color(c_white);
	draw_line(t_w4+10, t_h0+1, t_w0w4-10, t_h0+1);
	draw_set_color(c_ltgray);
	draw_line(t_w4+10, t_h0+2, t_w0w4-10, t_h0+2);*/
	draw_set_color(c_gold);
	draw_line(t_w4+1, -1, t_w4+1, t_h4+1);
	draw_set_color(c_black);
	draw_line(t_w4, -1, t_w4, t_h4);
	draw_line(t_w4+2, -1, t_w4+2, t_h4+2);
	draw_line(t_w4-1, t_h4+2, t_w4+2, t_h4+2);
	gpu_set_blendenable(true);
}

