if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+clamp(controller.shaking_sdev,0,10000)/10000*72,y+16);

draw_text(x+80,y+9,string(round(controller.shaking_sdev)));

