if (!controller.exp_optimize)
    exit;

draw_self();

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+22,y+2,"Only optimize between objects");
draw_set_color(c_white);

