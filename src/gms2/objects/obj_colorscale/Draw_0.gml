
draw_self();
if (moving)
{
    redy_upper = y+52-controller.red_scale*52;
    greeny_upper = y+52-controller.green_scale*52;
    bluey_upper = y+52-controller.blue_scale*52;
    
    redy_lower = y+52-controller.red_scale_lower*52;
    greeny_lower = y+52-controller.green_scale_lower*52;
    bluey_lower = y+52-controller.blue_scale_lower*52;
}
draw_sprite(spr_colorselect_red,(moving == 4),redx,redy_lower);
draw_sprite(spr_colorselect_green,(moving == 5),greenx,greeny_lower);
draw_sprite(spr_colorselect_blue,(moving == 6),bluex,bluey_lower);
draw_sprite(spr_colorselect_red,(moving == 1),redx,redy_upper);
draw_sprite(spr_colorselect_green,(moving == 2),greenx,greeny_upper);
draw_sprite(spr_colorselect_blue,(moving == 3),bluex,bluey_upper);

draw_set_colour(c_dkgray);
draw_text(x+60,y+25,string_hash_to_newline("Color range"));

draw_rectangle(redx+7,y+2,redx+9,redy_upper+1,0);
draw_rectangle(redx+7,redy_lower+9,redx+9,y+60,0);
draw_rectangle(greenx+7,y+2,greenx+9,greeny_upper+1,0);
draw_rectangle(greenx+7,greeny_lower+9,greenx+9,y+60,0);
draw_rectangle(bluex+7,y+2,bluex+9,bluey_upper+1,0);
draw_rectangle(bluex+7,bluey_lower+9,bluex+9,y+60,0);

