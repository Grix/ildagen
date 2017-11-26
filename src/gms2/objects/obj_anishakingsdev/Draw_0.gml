if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_aniknob,(moving > 0),x+clamp(controller.anishaking_sdev,0,10000)/10000*72,y+16);

draw_set_color(c_teal);
draw_text(x+80,y+9,string(round(controller.anishaking_sdev)));
draw_set_color(c_black);
