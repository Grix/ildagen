if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+clamp(livecontrol.masterred,0,1)*72,y+16);

draw_text(x+80,y+9,"Red");

