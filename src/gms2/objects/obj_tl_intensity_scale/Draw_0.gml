if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_knob,(moving > 0),x+floor(clamp(seqcontrol.intensity_scale,0,1)*128),y+16);

draw_text(x+150,y+9,"Intensity: "+string(round(seqcontrol.intensity_scale*100)) + "%");

