if (controller.anienable == 1) or (controller.maxframes == 1)
    draw_set_alpha(0.6);

draw_self();

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_set_halign(fa_center);
draw_text(x+8,y+20,string_hash_to_newline("Current#frame only"));
draw_set_halign(fa_left);
draw_set_color(c_white);

draw_set_alpha(1);

