draw_set_alpha(1);
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
    

if (!surface_exists(surf_profilelist))
{
    var t_ypos = 0;
    surf_profilelist = surface_create(512,512);
    surface_set_target(surf_profilelist);
        draw_clear_alpha(c_white,0);
        gpu_set_blendenable(false);
        draw_set_colour(c_black);
        draw_set_valign(fa_middle);
        for (i = 0; i < ds_list_size(controller.profile_list); i++)
        {
            if (i == controller.projector)
            {
                draw_set_color(controller.c_gold);
                draw_set_alpha(0.4);
                gpu_set_blendenable(true);
                draw_rectangle(0,t_ypos+1,list_width,t_ypos+itemh,0);
                gpu_set_blendenable(false);
                draw_set_alpha(1);
                draw_set_colour(c_black);
                draw_sprite(spr_checkbox,1,5,t_ypos+4);
                draw_text(35, t_ypos+itemh/2, string_hash_to_newline(ds_map_find_value(controller.profile_list[| i], "name")));
            }
            else
                draw_text(10, t_ypos+itemh/2, string_hash_to_newline(ds_map_find_value(controller.profile_list[| i], "name")));
            
            t_ypos += itemh;
            draw_line(0, t_ypos, list_width, t_ypos);
        }
        draw_set_valign(fa_top);
        gpu_set_blendenable(true);
    surface_reset_target();
    scrollh = t_ypos;
}

draw_surface_part(surf_profilelist, 0, round(scrollx), list_width, list_height, x, y);

