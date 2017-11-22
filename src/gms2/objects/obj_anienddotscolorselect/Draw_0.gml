if (view_current != 0)
    exit;

gpu_set_blendenable(false);

draw_self();
if (moving)
{
    activecolor = controller.anienddotscolor;
    redy = round(y+23-(colour_get_red(activecolor)/255*23));
    greeny = round(y+23-(colour_get_green(activecolor)/255*23));
    bluey = round(y+23-(colour_get_blue(activecolor)/255*23));
}
draw_sprite(spr_anicolorselectred,(moving == 1),redx,redy);
draw_sprite(spr_anicolorselectgreen,(moving == 2),greenx,greeny);
draw_sprite(spr_anicolorselectblue,(moving == 3),bluex,bluey);

draw_set_colour(activecolor);
    draw_rectangle(x+5,y-30,x+42,y-11,0);
draw_set_color(c_aqua);
    draw_rectangle(x+5,y-30,x+42,y-11,1);
	
draw_set_color(c_black);

gpu_set_blendenable(true);
