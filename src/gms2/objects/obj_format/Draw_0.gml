draw_self();

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+80,y+3,string_hash_to_newline("Format: "+string(controller.exp_format)));
draw_set_color(c_white);

