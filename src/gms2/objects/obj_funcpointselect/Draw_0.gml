if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+floor(clamp(controller.shapefunc_cp,0,400)/400*128),y+16);

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+150,y+9,string_hash_to_newline("Points: "+string(round(controller.shapefunc_cp))));
draw_set_color(c_white);


