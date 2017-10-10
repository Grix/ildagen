draw_set_color(c_gray);
//draw_line(0,400,1300,400);

if (room != rm_ilda) 
    exit;
if (view_current == 0)
{
    //hershey symbol selector
    if (placing = "hershey")
    {
        draw_sprite_part(bck_hershey3,0,0,clamp(hershey_scrollx-4096,0,2048),420,120-clamp(4096-hershey_scrollx,0,120),650,30+clamp(4096-hershey_scrollx,0,120));
        draw_sprite_part(bck_hershey2,0,0,clamp(hershey_scrollx-2048,0,2048),420,120-clamp(2048-hershey_scrollx,0,120),650,30+clamp(2048-hershey_scrollx,0,120));
        draw_sprite_part(bck_hershey1,0,0,clamp(hershey_scrollx,0,2048),420,120,650,30);
        
        draw_set_alpha(1);
        draw_set_colour(c_white);
        draw_rectangle(1070,30,1090,150,0);
        draw_set_colour(c_black);
        draw_rectangle(1070,30,1090,150,1);
        draw_set_colour(c_dkgray);
        draw_rectangle(1070,30+hershey_scrollx*100/hershey_scrollh,1090,30+hershey_scrollx*100/hershey_scrollh+hershey_scrollw,0);
        
        yo = ceil((hershey_selected+1)/14)*30-30;
        if (yo = clamp(yo,hershey_scrollx-30,hershey_scrollx+120))
        {
            draw_set_alpha(0.3)
            draw_set_colour(c_gold);
            xo = (hershey_selected mod 14)*30;
            draw_rectangle(650+xo,max(30+yo-hershey_scrollx,30),680+xo,min(30+yo-hershey_scrollx+30,150),0);
        }
    }
    
    //mine timeline + cursors
    if (!surface_exists(minitimeline_surf) || refresh_minitimeline_flag)
    {
        refresh_minitimeline_surf();
        refresh_minitimeline_flag = 0;
    }
    draw_set_color(c_white);
    draw_set_alpha(1);
    if (surface_exists(minitimeline_surf))
        draw_surface_part(minitimeline_surf,0,0,tlw,tlh+1,tlorigo_x,tlorigo_y);
    if (maxframes > 1)
    {
        draw_set_color(c_black);
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
    
    if (!laseron)
    {
        if (bckimage)
        {
            if (!keyboard_check(ord("E")))
                draw_set_alpha(0.3);
            if (sprite_exists(bck_bckimage))
            {
                draw_sprite_stretched(bck_bckimage,0,bckimage_left,bckimage_top,bckimage_width,bckimage_height);
            }
            else bckimage = 0;
        }
        
        if (object_select_hovering = 1)
        {
            draw_set_alpha(0.5);
            draw_set_colour(c_teal);
                draw_rectangle(rectxmin2,rectymin2,rectxmax2,rectymax2,1);
            draw_set_alpha(1);
            draw_set_colour(c_white);
        }
        else if (object_select_hovering = 2)
        {
            draw_set_alpha(0.7);
            draw_set_colour(c_maroon);
                draw_rectangle(rectxmin2,rectymin2,rectxmax2,rectymax2,1);
            draw_set_alpha(1);
            draw_set_colour(c_white);
        }
        
        draw_set_color(c_gray);
        if (objmoving == 3)
            draw_text(20,20,string_format(anirot,3,2)+" deg");
        else if (objmoving == 1)
        {
            draw_text(20,20,"X translation: "+string_format(anixtrans,5,0));
            draw_text(20,40,"Y translation: "+string_format(aniytrans,5,0));
        }
        else if (objmoving == 2)
        {
            draw_text(20,20,"Anchor X: "+string_format(anchorx,5,0));
            draw_text(20,40,"Anchor Y: "+string_format(anchory,5,0));
        }
        else if (objmoving == 4)
        {
            draw_text(20,20,"X scale: "+string_format(scalex,2,3));
            draw_text(20,40,"Y scale: "+string_format(scaley,2,3));
        }
        draw_set_color(c_white);
            
        draw_set_alpha(0.7);
           
        //grids 
        if (keyboard_check(ord("S")) || (sgridshow == 1))
        {
            if (!surface_exists(squaregrid_surf))
            {
                squaregrid_surf = surface_create(512,512);
                surface_set_target(squaregrid_surf);
                    draw_grid();
                surface_reset_target();
            }
            draw_surface(squaregrid_surf,0,0);
        } 
        if (keyboard_check(ord("R")) || (rgridshow == 1))
        {
            if (!surface_exists(radialgrid_surf))
            {
                radialgrid_surf = surface_create(512,512);
                surface_set_target(radialgrid_surf);
                    draw_radialgrid();
                surface_reset_target();
            }
            draw_surface(radialgrid_surf,0,0);
        }
            
        if ((keyboard_check(ord("A")) && !keyboard_check(vk_control)) || (guidelineshow == 1))
        {
            draw_guidelines();
        }
        
        draw_set_alpha(1);
        draw_set_color(c_gray);
        if (highlight)
        {
            for (u = 0; u < ds_list_size(el_list);u++)
            {
                templist = ds_list_find_value(el_list,u);
                
                xo = ds_list_find_value(templist,0)/$ffff*512;
                yo = ds_list_find_value(templist,1)/$ffff*512;
                
                xp1 = xo+ds_list_find_value(templist,4);
                yp1 = yo+ds_list_find_value(templist,6);
                xp2 = xo+ds_list_find_value(templist,5);
                yp2 = yo+ds_list_find_value(templist,7);
                draw_rectangle(xp1,yp1,xp2,yp2,1);
            }
        }
        
        //selected elements
        draw_set_color(c_aqua);
        if !(ds_list_empty(semaster_list))//(selectedelement != -1)
        {
            if (update_semasterlist_flag)
                update_semasterlist();
            
            draw_sprite(spr_anchor,0,round(anchorx/$ffff*512),round(anchory/$ffff*512));
            draw_set_alpha(0.6);
            draw_sprite(spr_rotate,0,rectxmin,rectymax);
            draw_sprite(spr_resize,0,rectxmax,rectymax);
            draw_set_alpha(1);
            
            draw_rectangle(rectxmin,rectymin,rectxmax,rectymax,1);
            
            if (objmoving == 1) || (objmoving == 3) || (objmoving == 4)
            {
                xp1 = rectxmin+anixtrans/$ffff*512;
                yp1 = rectymin+aniytrans/$ffff*512;
                xp2 = rectxmax+anixtrans/$ffff*512;
                yp2 = rectymax+aniytrans/$ffff*512;
                xp3 = rectxmax+anixtrans/$ffff*512;
                yp3 = rectymin+aniytrans/$ffff*512;
                xp4 = rectxmin+anixtrans/$ffff*512;
                yp4 = rectymax+aniytrans/$ffff*512;
                rot_r = degtorad(anirot);
                
                angle1 = degtorad(point_direction(anchorx/$ffff*512,anchory/$ffff*512,xp1,yp1));
                dist1 = point_distance(anchorx/$ffff*512,anchory/$ffff*512,xp1,yp1);
                
                xpnew1 = anchorx/$ffff*512+cos(rot_r-angle1)*dist1*scalex;
                ypnew1 = anchory/$ffff*512+sin(rot_r-angle1)*dist1*scaley;
                
                angle2 = degtorad(point_direction(anchorx/$ffff*512,anchory/$ffff*512,xp2,yp2));
                dist2 = point_distance(anchorx/$ffff*512,anchory/$ffff*512,xp2,yp2);
                
                xpnew2 = anchorx/$ffff*512+cos(rot_r-angle2)*dist2*scalex;
                ypnew2 = anchory/$ffff*512+sin(rot_r-angle2)*dist2*scaley;
        
                angle3 = degtorad(point_direction(anchorx/$ffff*512,anchory/$ffff*512,xp3,yp3));
                dist3 = point_distance(anchorx/$ffff*512,anchory/$ffff*512,xp3,yp3);
                
                xpnew3 = anchorx/$ffff*512+cos(rot_r-angle3)*dist3*scalex;
                ypnew3 = anchory/$ffff*512+sin(rot_r-angle3)*dist3*scaley;
                
                angle4 = degtorad(point_direction(anchorx/$ffff*512,anchory/$ffff*512,xp4,yp4));
                dist4 = point_distance(anchorx/$ffff*512,anchory/$ffff*512,xp4,yp4);
                
                xpnew4 = anchorx/$ffff*512+cos(rot_r-angle4)*dist4*scalex;
                ypnew4 = anchory/$ffff*512+sin(rot_r-angle4)*dist4*scaley;
                
        
                draw_set_color(c_teal);
                draw_rectangle(xp1,yp1,xp2,yp2,1);
                
                draw_line(xpnew1,ypnew1,xpnew3,ypnew3);
                draw_line(xpnew2,ypnew2,xpnew3,ypnew3);
                draw_line(xpnew2,ypnew2,xpnew4,ypnew4);
                draw_line(xpnew4,ypnew4,xpnew1,ypnew1);
            
                if (objmoving == 1)
                {
                    draw_set_alpha(0.4);
                        draw_arrow(mean(rectxmin,rectxmax),mean(rectymin,rectymax),mean(xpnew1,xpnew2),mean(ypnew1,ypnew2),12);
                    draw_set_alpha(1);
                }
            }
            
        }
        
        if (placing_status) || (placing == "text") || (placing == "hershey") 
            draw_preview_element();
    }
    
    //info text
    draw_set_alpha(0.8);
    draw_set_font(fnt_tooltip);
    
        draw_set_color(c_ltgray);
        draw_text(12,495,"Frame: "+string(frame+1)+"/"+string(maxframes));
        
        draw_text(12,7,"FPS: "+string(projectfps));
        if (playing && (fps != projectfps) && laseron)
        {
            draw_set_color(c_red);
            draw_text(32,7,"Warning: Dropping frames. Actual FPS: "+string(fps));
        }
        
        if (frame_complexity == 1)
            draw_set_color(c_red);
        else if (frame_complexity == 2)
            draw_set_color(c_orange);
        else 
            draw_set_color(c_ltgray);
        draw_text(440,495,"Points: "+string(framepoints));
        
        if (!anienable) && (maxframes < 2)
            draw_set_color(c_gray);
        else 
            draw_set_color(c_ltgray);
        if (scope_start == 0) && (scope_end == maxframes-1)
            draw_text(220,495,"Scope: All frames");
        else
            draw_text(220,495,"Scope: "+string(scope_start+1)+" - "+string(scope_end+1));
            
    draw_set_colour(c_black);
    draw_set_alpha(1);
    
    gpu_set_blendenable(0);
    with (obj_button_parent)
    {
        draw_self();
    }
    gpu_set_blendenable(1);
}
else if (view_current == 3)
{
    draw_set_colour(c_black);
    draw_set_alpha(1);
    
    //menu
    draw_text(0,__view_get( e__VW.YView, 3 )+4,menu_string);
    if (mouse_y > __view_get( e__VW.YView, 3 ))   
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
        else if (mouse_x > menu_width_start[6]) && (mouse_x < menu_width_start[7])
        {
            draw_rectangle(menu_width_start[6],__view_get( e__VW.YView, 3 )+1,menu_width_start[7],__view_get( e__VW.YView, 3 )+20,1);
            draw_set_alpha(0.3);
            draw_rectangle(menu_width_start[6],__view_get( e__VW.YView, 3 )+1,menu_width_start[7],__view_get( e__VW.YView, 3 )+20,0);
        }
        draw_set_alpha(1);
    }
    draw_set_colour(c_white);
}

