var t_plist = seqcontrol.layer_list;

if (!surface_exists(surf_projectorlist))
{
    var t_ypos = 0;
    surf_projectorlist = surface_create(512,512);
    surface_set_target(surf_projectorlist);
        draw_clear_alpha(controller.c_ltltgray,1);
        //gpu_set_blendenable(false);
        draw_set_colour(c_black);
        draw_set_valign(fa_middle);
        for (i = 0; i < ds_list_size(t_plist); i++)
        {
            var t_thisplist = t_plist[| i];
			var t_text = t_thisplist[| 4] + " (X = "+ string(round(t_thisplist[| 6])) + ", Y = "+ string(round(t_thisplist[| 7]))+")";
			
            if (selected == i)
            {
                draw_set_color(controller.c_gold);
                draw_set_alpha(0.4);
                draw_rectangle(0,t_ypos+1,list_width,t_ypos+itemh,0);
                draw_set_alpha(1);
                draw_set_colour(c_black);
				draw_text(10, t_ypos+itemh/2, t_text);
            }
            else
				draw_text(10, t_ypos+itemh/2, t_text);
            
            t_ypos += itemh;
            draw_line(0, t_ypos, list_width, t_ypos);
            
        }
        draw_set_valign(fa_top);
    surface_reset_target();
    scrollh = t_ypos;
}

draw_surface_part(surf_projectorlist, 0, round(scrollx), list_width, list_height, x, y);

if (scrollh > list_height)
{
    draw_set_colour(c_white);
    draw_rectangle(x+list_width,y,x+list_width+20,y+list_height,0);
    draw_set_colour(c_dkgray);
    draw_rectangle(x+list_width, y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw), x+list_width+20, y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw)+scrollw, 0);
    draw_rectangle(x+list_width,y,x+list_width+20,y+list_height,1);
}
else
{
    scrollx = 0;
    draw_set_colour(c_dkgray);
}
draw_rectangle(x,y,x+list_width,y+list_height,1);


draw_set_color(c_black);

draw_rectangle(x+canvas_x,y, x+canvas_x+canvas_width, y+canvas_width, 0);

for (i = 0; i < ds_list_size(t_plist); i++)
{
    var t_thisplist = t_plist[| i];
	
    if (selected == i)
	{
		draw_set_alpha(1);
		draw_sprite(spr_projectoroffset, 0, x+canvas_x+canvas_width/2+canvas_width/$ffff*t_thisplist[| 6], y+canvas_width/2+canvas_width/$ffff*t_thisplist[| 7]);
		draw_set_color(c_gray);
		draw_set_halign(fa_middle);
		draw_text(x+canvas_x+canvas_width/2+canvas_width/$ffff*t_thisplist[| 6], y+canvas_width/2+canvas_width/$ffff*t_thisplist[| 7]-27, string(i+1));
	}	
	else
	{
		draw_set_alpha(0.5);
		draw_sprite(spr_projectoroffset, 0, x+canvas_x+canvas_width/2+canvas_width/$ffff*t_thisplist[| 6], y+canvas_width/2+canvas_width/$ffff*t_thisplist[| 7]);
		draw_set_color(c_gray);
		draw_set_halign(fa_middle);
		draw_text(x+canvas_x+canvas_width/2+canvas_width/$ffff*t_thisplist[| 6], y+canvas_width/2+canvas_width/$ffff*t_thisplist[| 7]-27, string(i+1));
	}	
}

draw_set_alpha(1);
draw_set_color(c_black);
draw_set_halign(fa_left);