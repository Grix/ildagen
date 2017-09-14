if (controller.anienable == 1) image_index = 1;
else image_index = 0;

draw_self();

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_set_halign(fa_center);
draw_text(x+8,y+20,string_hash_to_newline("Enabled"));
draw_set_halign(fa_left);
draw_set_color(c_white);

