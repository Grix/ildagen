if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),floor(x+clamp(controller.wave_offset,0,360)/360*128),y+16);

draw_text(x+150,y+9,"Offset: "+string(round(controller.wave_offset))+" deg");


