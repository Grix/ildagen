if (view_current != 4)
	exit;
	
	
list_height = (view_hport[4]-58*controller.dpi_multiplier)/controller.dpi_multiplier;

draw_set_alpha(1);
if (!surface_exists(surf_playlist))
{
    var t_ypos = 0;
	draw_set_alpha(1);
	draw_set_font(fnt_tooltip);
    surf_playlist = surface_create(512,512);
    surface_set_target(surf_playlist);
        draw_clear_alpha(c_black,1);
        //gpu_set_blendenable(false);
        draw_set_colour(c_white);
        draw_set_valign(fa_middle);
        for (i = 0; i < ds_list_size(seqcontrol.playlist_list); i++)
        {
            /*if (i == controller.projector)
            {
                draw_set_color(controller.c_gold);
                draw_set_alpha(0.4);
                //gpu_set_blendenable(true);
                draw_rectangle(0,t_ypos+1,list_width,t_ypos+itemh,0);
                //gpu_set_blendenable(false);
                draw_set_alpha(1);
                draw_set_colour(c_black);
                draw_sprite(spr_checkbox,1,5,t_ypos+4);
                draw_text(35, t_ypos+itemh/2, ds_map_find_value(controller.profile_list[| i], "name"));
            }
            else*/
                draw_text(10, t_ypos+itemh/2, filename_change_ext(filename_name(seqcontrol.playlist_list[| i]), ""));
            
            t_ypos += itemh;
            draw_line(0, t_ypos, list_width, t_ypos);
        }
        draw_set_valign(fa_top);
        //gpu_set_blendenable(true);
    surface_reset_target();
    scrollh = t_ypos;
}

x = view_wport[4] - (list_width+20+10)*controller.dpi_multiplier;
y = 36*controller.dpi_multiplier;

draw_surface_part_ext(surf_playlist, 0, round(scrollx), list_width, list_height, x, y, controller.dpi_multiplier, controller.dpi_multiplier, c_white, 0.7);

var t_mouseover = (scrollx + (mouse_y - y)) div (itemh*controller.dpi_multiplier);
if (mouse_x > x && mouse_x < x+list_width*controller.dpi_multiplier && t_mouseover >= 0 && t_mouseover < ds_list_size(seqcontrol.playlist_list))
{
	draw_set_alpha(0.2);
	draw_set_color(c_black);
	draw_rectangle(x,y+itemh*t_mouseover*controller.dpi_multiplier,x+list_width*controller.dpi_multiplier,y+itemh*(t_mouseover+1)*controller.dpi_multiplier,0);
	draw_set_alpha(1);
}

if (scrollh > list_height)
{
    draw_set_colour(c_white);
    draw_rectangle(x+list_width*controller.dpi_multiplier,y,x+(list_width+20)*controller.dpi_multiplier,y+list_height*controller.dpi_multiplier,0);
    draw_set_colour(c_ltgray);
    draw_rectangle(x+list_width*controller.dpi_multiplier, y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw)*controller.dpi_multiplier, x+(list_width+20)*controller.dpi_multiplier, y+(scrollx)/(scrollh-scrollw)*(list_height-scrollw)*controller.dpi_multiplier+scrollw*controller.dpi_multiplier, 0);
    draw_rectangle(x+list_width*controller.dpi_multiplier,y,x+(list_width+20)*controller.dpi_multiplier,y+list_height*controller.dpi_multiplier,1);
}
else
{
    scrollx = 0;
    draw_set_colour(c_ltgray);
}
draw_rectangle(x,y,x+list_width*controller.dpi_multiplier,y+list_height*controller.dpi_multiplier,1);

var t_rightx = view_wport[4];
draw_set_color(controller.c_ltltgray);
draw_text_transformed(t_rightx - (list_width+5)*controller.dpi_multiplier, 14, "Playlist:", controller.dpi_multiplier, controller.dpi_multiplier, 0);
	
if (mouseover_addbutton)
	draw_set_alpha(0.8);
else
	draw_set_alpha(1);

draw_sprite_stretched(spr_addlayer, 0, x + (list_width - 24)*controller.dpi_multiplier, y + (list_height- 24)*controller.dpi_multiplier, 16*controller.dpi_multiplier, 16*controller.dpi_multiplier);

draw_set_alpha(1);
draw_set_color(c_black);