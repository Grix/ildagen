draw_self();

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+60,y+3,"Max acceleration: "+string(controller.opt_maxdist));
draw_set_color(c_white);

