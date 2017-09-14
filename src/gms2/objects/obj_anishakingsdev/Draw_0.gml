if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_aniknob,(moving > 0),x+clamp(controller.anishaking_sdev,0,50)/50*72,y+16);

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+80,y+9,string_hash_to_newline(string(round(controller.anishaking_sdev))));
draw_set_color(c_white);


