if (view_current != 0)
    exit;

draw_set_alpha(1);
draw_self();
draw_sprite(spr_knob,(moving > 0),x+clamp(controller.blank_offset,0,360)/360*128,y+16);

draw_set_font(fnt_tooltip);
draw_set_color(c_dkgray);
draw_text(x+150,y+9,"Offset: "+string(round(controller.blank_offset))+" deg");
draw_set_color(c_white);


