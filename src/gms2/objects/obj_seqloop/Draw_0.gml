if (seqcontrol.loop == true) 
    image_index = 1;
else 
    image_index = 0;

draw_self();

draw_set_color(c_dkgray);
draw_set_font(fnt_tooltip);
draw_text(x+22,y+2,"Loop");
draw_set_color(c_white);

