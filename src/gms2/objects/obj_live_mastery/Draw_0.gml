if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+(clamp(livecontrol.mastery,-$8000,$8000)/$ffff+$8000)*72,y+16);

draw_text(x+80,y+9,"Intensity");

