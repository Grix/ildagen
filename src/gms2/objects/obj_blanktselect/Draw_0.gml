if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+clamp(controller.blank_period,-$8000,$8000)/$8000*128,y+16);

draw_text(x+150,y+9,"Period: "+string(round(controller.blank_period)));

