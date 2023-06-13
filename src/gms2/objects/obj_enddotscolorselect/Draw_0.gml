if (view_current != 0)
    exit;

gpu_set_blendenable(false);

draw_self();
if (moving)
{
    activecolor = controller.enddotscolor;
    redy = round(y+23-(color_get_red(activecolor)/255*23));
    greeny = round(y+23-(color_get_green(activecolor)/255*23));
    bluey = round(y+23-(color_get_blue(activecolor)/255*23));
}
draw_sprite(spr_colorselect_red,(moving == 1),redx,redy);
draw_sprite(spr_colorselect_green,(moving == 2),greenx,greeny);
draw_sprite(spr_colorselect_blue,(moving == 3),bluex,bluey);

draw_set_colour(activecolor);
    draw_rectangle(x+5,y-30,x+42,y-11,0);
draw_set_color(c_black);
    draw_rectangle(x+5,y-30,x+42,y-11,1);

draw_sprite(spr_tt_dotcolor, 0, x-5, y-60);

gpu_set_blendenable(true);