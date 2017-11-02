if (view_current != 0)
    exit;
    
draw_self();
if (moving)
{
    activecolor = controller.color2;
    redy = round(y+23-(colour_get_red(activecolor)/255*23));
    greeny = round(y+23-(colour_get_green(activecolor)/255*23));
    bluey = round(y+23-(colour_get_blue(activecolor)/255*23));
}
draw_sprite(spr_colorselect_red,(moving == 1),redx,redy);
draw_sprite(spr_colorselect_green,(moving == 2),greenx,greeny);
draw_sprite(spr_colorselect_blue,(moving == 3),bluex,bluey);

draw_set_colour(activecolor);
    draw_rectangle(x+5,y-30,x+42,y-11,0);
draw_set_color(c_black);
    draw_rectangle(x+5,y-30,x+42,y-11,1);

draw_sprite(spr_tt_secondarycol, 0, x-5, y-60);