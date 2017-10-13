if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+controller.blank_dc*2*64,y+16);

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+150,y+9,"Ratio: "+string(controller.blank_dc));
draw_set_color(c_white);


